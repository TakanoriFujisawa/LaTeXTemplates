#!/bin/bash

cd $(dirname "$BASH_SOURCE")

rm -f manuscript_english_sample.pdf manuscript_japanese_sample.pdf

## 英語版のタイプセット
echo -e "\n[1] pdflatex"
pdflatex -file-line-error -halt-on-error manuscript_english.tex > /dev/null
echo -e "\n[2] bibtex"
bibtex manuscript_english.aux > /dev/null
echo -e "\n[3] pdflatex"
pdflatex -file-line-error -halt-on-error manuscript_english.tex > /dev/null
echo -e "\n[4] pdflatex"
pdflatex -file-line-error -halt-on-error manuscript_english.tex > /dev/null

if type optimize-pdf.sh > /dev/null; then
    echo -e "\n[6] optimize-pdf"
    optimize-pdf.sh manuscript_english.pdf manuscript_english_sample.pdf \
      || mv manuscript_english.pdf manuscript_english_sample.pdf
else
    echo -e "\n[6] creating sample"
    mv manuscript_english.pdf manuscript_english_sample.pdf
fi

## 日本語版のタイプセット
echo -e "\n[1] platex"
platex -file-line-error -halt-on-error manuscript_japanese.tex > /dev/null
echo -e "\n[2] pbibtex"
pbibtex manuscript_japanese.aux > /dev/null
echo -e "\n[3] platex"
platex -file-line-error -halt-on-error manuscript_japanese.tex > /dev/null
echo -e "\n[4] platex"
platex -file-line-error -halt-on-error manuscript_japanese.tex > /dev/null
echo -e "\n[5] dvipdfmx"
dvipdfmx manuscript_japanese.dvi

if type optimize-pdf.sh > /dev/null; then
    echo -e "\n[6] optimize-pdf"
    optimize-pdf.sh manuscript_japanese.pdf manuscript_japanese_sample.pdf \
      || mv manuscript_japanese.pdf manuscript_japanese_sample.pdf
else
    echo -e "\n[6] creating sample"
    mv manuscript_japanese.pdf manuscript_japanese_sample.pdf
fi

find . -name '.DS_Store' -delete
find . -name '._*' -delete
rm -f manuscript_{english,japanese}.{aux,bbl,blg,dvi,log,pdf}
rm -f *~

name=$(basename $(pwd))
cd ..
rm -f $name.zip

export COPYFILE_DISABLE=true
echo -e "\n[7] archive"
zip -9r $name.zip $name -x $name/archive_it.sh

