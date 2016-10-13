#!/bin/bash

# set scaling factor, 50% if nothing else is set
factor=${1:-50}

# create folder for copies
mkdir c

# do it!
for i in *jpg
do
	echo $
	convert $i -resize ${factor}% "c/$i"
done 
