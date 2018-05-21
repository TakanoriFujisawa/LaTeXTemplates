#!/bin/bash

cd $(dirname $BASH_SOURCE)

template_wd=$(pwd)
tmpdir=$(mktemp -d /tmp/template-XXXXXXXX)

if [ x$tmpdir == "x" ]; then
    echo "Failed to create temporary directory"
    exit 1
fi

function cleanup-and-exit() {
    rm -rf "$tmpdir"
    exit $1
}



## 1. サンプル用にタイプセットを走らせる
rm -f seminar.pdf
rm -f seminar.{aux,dvi,bbl,blg,log,toc,synctex.gz}
platex -halt-on-error seminar.tex > /dev/null
platex -halt-on-error seminar.tex > /dev/null
dvipdfmx seminar.dvi > /dev/null
if ! [ -e seminar.pdf ]; then 
    echo "Failed to generate seminar.pdf"
    cleanup-and-exit 1; 
fi


## 2. サンプルファイルを作成
mv seminar.pdf seminar-sample.pdf


## 3. 一時ファイルを削除
rm -f seminar.{aux,dvi,bbl,blg,log,toc,synctex.gz,tex.part}

rm -f preamble.{aux,log}

rm -f figure/*.xbb


## 4. Emacs バックアップファイルを削除
rm -f *~


## 5. 一時ディレクトリにコピー
templatedir=$(basename $(pwd))
cd ..

if ! [ -d "$templatedir" ]; then
    echo "Failed to get template directory name"
    cleanup-and-exit 1
fi

cp -r "$templatedir" "${tmpdir}/"

cd "$tmpdir"

if ! [ -d "$templatedir" ]; then
    echo "Failed to copy template directory"
    cleanup-and-exit 1
fi


# 6. 配布に不要なファイルを削除
rm -rf "${templatedir}/backnumber" "${templatedir}/archive-it.sh" "${templatedir}/ChangeLog"
rm -f "${templatedir}/jsarticle.cls" "${templatedir}/IEEEtran.cls"

# 7. 圧縮ファイルを生成
export COPYFILE_DISABLE=1
rm -f "${templatedir}.zip"
zip -9r "${templatedir}.zip" "$templatedir" -x '*/.DS_Store'

# 8. 作業ディレクトリの一つ上の階層に移動
cd "$template_wd"
mv -v "${tmpdir}/${templatedir}.zip" ".."

cleanup-and-exit

