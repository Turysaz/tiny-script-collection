#!/bin/sh

# renders tex project
# requires nomencl.ist to be within the directory

file=${1:-main}

pdflatex $file.tex
makeindex $file.nlo -s nomencl.ist -o $file.nls
bibtex $file
pdflatex $file.tex
pdflatex $file.tex

