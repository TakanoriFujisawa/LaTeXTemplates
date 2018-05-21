#!/bin/bash

cd $(dirname "$BASH_SOURCE")

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

rm -f manuscript-sample.pdf

if type optimize-pdf.sh > /dev/null; then
    echo -e "\n[6] optimize-pdf"
    optimize-pdf.sh manuscript.pdf manuscript-sample.pdf \
      || mv manuscript.pdf manuscript-sample.pdf
else
    echo -e "\n[6] creating sample"
    mv manuscript.pdf manuscript-sample.pdf
fi

find . -name '.DS_Store' -delete
find . -name '._*' -delete
rm -f manuscript.{aux,bbl,blg,dvi,log,pdf}
rm -f preamble.{aux,log}
rm -f *~

name=$(basename $(pwd))
cd ..
rm -f $name.zip

export COPYFILE_DISABLE=true
echo -e "\n[7] archive"
zip -9r $name.zip $name -x $name/archive_it.sh

exit

[ -d /Volumes/home/Template ] && cp -v ../IEEEConference.zip /Volumes/home/Template/IEEEConference.zip
