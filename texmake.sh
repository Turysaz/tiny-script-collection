#!/bin/sh

# renders tex project
# requires nomencl.ist to be within the directory

_file=${1:-main}

pdflatex $_file.tex
makeindex $_file.nlo -s nomencl.ist -o $_file.nls
bibtex $_file
pdflatex $_file.tex
pdflatex $_file.tex

