
# create logbook entry
function log
{
    eTitle=log-$(date '+%Y-%m-%d')
    ePath=~/logbook/
    entry=$ePath$eTitle.md

    if [ ! -e $entry ]
    then
        echo new logbook entry
        echo "$eTitle" > $entry
        echo "==============" >> $entry
    fi

    vim $entry

    old_dir=$(pwd)
    cd $ePath
    git add *
    git commit -a -m"Automated logbook commit"
    cd $old_dir
}


# search logbook
function log-search
{
    ePath=~/logbook/
    grep -ir --exclude-dir=.git $1 $ePath
}

