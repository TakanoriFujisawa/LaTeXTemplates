#!/bin/bash

cd $(dirname $BASH_SOURCE)

template_wd=$(pwd)

if [ $(uname) = "Darwin" ]; then
    tmpdir=$(mktemp -d /tmp/template-XXXXXXXX)
else
    tmpdir=$(mktemp --tmpdir -d template-XXXXXXXX)
fi
    
if [ x$tmpdir = "x" ]; then
    echo "Failed to create temporary directory"
    exit 1
fi

function cleanup-and-exit() {
    rm -rf "$tmpdir"
    exit $1
}

## 0. sotsuron.tex / shuron.tex の共通部分が同じかどうか比較する
grep -A 20000 %%%%% sotsuron.tex > sotsuron.tex.part
grep -A 20000 %%%%% shuron.tex > shuron.tex.part

if ! diff sotsuron.tex.part shuron.tex.part; then
    echo "File sotsuron.tex and shuron.tex differs"
    cleanup-and-exit 1
fi


## 1. サンプル用にタイプセットを走らせる
rm -f sotsuron.pdf
rm -f sotsuron.{aux,dvi,bbl,blg,log,toc,out,synctex.gz}
echo "--- platex sotsuron.tex [1]"
platex -halt-on-error sotsuron.tex > /dev/null
echo "--- pbibtex sotsuron.aux"
pbibtex sotsuron.aux > /dev/null
echo "--- platex sotsuron.tex [2]"
platex -halt-on-error sotsuron.tex > /dev/null
echo "--- platex sotsuron.tex [3]"
platex -halt-on-error sotsuron.tex > /dev/null
echo "--- dvipdfmx sotsuron.dvi"
dvipdfmx sotsuron.dvi > /dev/null
if ! [ -e sotsuron.pdf ]; then 
    echo "Failed to generate sotsuron.pdf"
    cleanup-and-exit 1; 
fi

rm -f shuron.pdf
rm -f shuron.{aux,dvi,bbl,blg,log,toc,out,synctex.gz}
echo "--- platex shuron.tex [1]"
platex -halt-on-error shuron.tex > /dev/null
echo "--- pbibtex shuron.aux"
pbibtex shuron.aux > /dev/null
echo "--- platex shuron.tex [2]"
platex -halt-on-error shuron.tex > /dev/null
echo "--- platex shuron.tex [3]"
platex -halt-on-error shuron.tex > /dev/null
echo "--- dvipdfmx shuron.dvi"
dvipdfmx shuron.dvi > /dev/null
if ! [ -e shuron.pdf ]; then 
    echo "Failed to generate shuron.pdf"
    cleanup-and-exit 1; 
fi

## 2. サンプルファイルを作成
mv sotsuron.pdf sotsuron-sample.pdf
mv shuron.pdf shuron-sample.pdf


## 3. 一時ファイルを削除
rm -f sotsuron.{aux,dvi,bbl,blg,log,toc,out,synctex.gz,tex.part}
rm -f shuron.{aux,dvi,bbl,blg,log,toc,out,synctex.gz,tex.part}

rm -f preamble.{aux,log}

rm -f kanjix.map

rm -f figure/*.xbb

## 4. Emacs バックアップファイルを削除
rm -f *~

## 5. 拡張属性を削除
 [ $(uname) = "Darwin" -a  -e /usr/bin/xattr ] && xattr -rc .
find . -name '.DS_Store' -delete
find . -name '._*' -delete

## 6. 一時ディレクトリにコピー
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
rm -rf "${templatedir}/backnumber"
rm -rf "${templatedir}/archive-it.sh"
rm -rf "${templatedir}/ChangeLog"


# 7. 圧縮ファイルを生成
unset ZIP ZIPINFO
export COPYFILE_DISABLE=1
zip -9r "${templatedir}.zip" "$templatedir"


# 8. 作業ディレクトリの一つ上の階層に移動
cd "$template_wd"
mv -v "${tmpdir}/${templatedir}.zip" ".."

if [ $? -eq 0 ] && [ -e ${template_wd}/../${templatedir}.zip ]; then
    echo "Successfully create template archive!"
fi

cleanup-and-exit


# 9. アップロード (ターミナルにコピペして実行)
if [ -d /Volumes/home/Template ]; then
    cp -v ~/Dropbox/TeX/thesis-template2017.zip /Volumes/home/Template/
fi


