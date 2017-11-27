#!/bin/sh

WPLNK=$HOME/Pictures/current_wallpaper.png

show_help()
{
    echo "Usage: gnome3-setbg.sh [--help | PATH]"
    echo "[PATH] = file path of new background image"
    echo "The --help flag prints this info text"
}

# check existence of input argument
if [ $# -eq 0 ]
then
    echo "ERROR: no arguments passed!"
    echo
    show_help
    exit 0
fi

if [ $1 == "--help" ]
then
    show_help
    exit 0
fi

rm $WPLNK
ln -s $1 $WPLNK

unset WPLNK
