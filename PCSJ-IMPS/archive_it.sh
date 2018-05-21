#!/bin/bash

cd $(dirname "$BASH_SOURCE")

rm -vf manuscript.{aux,log,bbl,blg,out}
rm -vf manuscript-english.{aux,log,bbl,blg,out}

echo -e "\n[1] pdflatex"
pdflatex -file-line-error -halt-on-error manuscript-english.tex > /dev/null
echo -e "\n[2] bibtex"
bibtex manuscript-english.aux > /dev/null
echo -e "\n[3] pdflatex"
pdflatex -file-line-error -halt-on-error manuscript-english.tex > /dev/null
echo -e "\n[4] pdflatex"
pdflatex -file-line-error -halt-on-error manuscript-english.tex > /dev/null

mv -v manuscript-english.pdf manuscript-english-sample.pdf

echo -e "\n[1] platex"
platex -file-line-error -halt-on-error manuscript.tex > /dev/null
echo -e "\n[2] bibtex"
bibtex manuscript.aux > /dev/null
echo -e "\n[3] platex"
platex -file-line-error -halt-on-error manuscript.tex > /dev/null
echo -e "\n[4] platex"
platex -file-line-error -halt-on-error manuscript.tex > /dev/null
echo -e "\n[5] dvipdfmx"
dvipdfmx manuscript.dvi

rm -vf manuscript-sample.pdf

if type optimize-pdf.sh > /dev/null; then
    echo -e "\n[6] optimize-pdf"
    optimize-pdf.sh manuscript.pdf manuscript-sample.pdf \
      || mv manuscript.pdf manuscript-sample.pdf
else
    echo -e "\n[6] creating sample"
    mv -v manuscript.pdf manuscript-sample.pdf
fi

find . -name '.DS_Store' -delete
find . -name '._*' -delete
rm -vf manuscript.{aux,bbl,blg,dvi,log,pdf}
rm -vf manuscript-english.{aux,bbl,blg,dvi,log,pdf}
rm -vf preamble.{aux,log}
rm -vf *~

name=$(basename $(pwd))
cd ..
rm -f $name.zip

export COPYFILE_DISABLE=true
echo -e "\n[7] archive"
zip -9r $name.zip $name -x $name/archive_it.sh -x "$name/original/*" -x "$name/.discard/*"

exit

[ -d /Volumes/home/Template ] && cp -v ../PCSJ-IMPS.zip /Volumes/home/Template/PCSJ-IMPS.zip

[ -d /Volumes/homes/ikelab/Template ] && cp -v ../PCSJ-IMPS.zip /Volumes/homes/ikelab/Template/PCSJ-IMPS.zip
