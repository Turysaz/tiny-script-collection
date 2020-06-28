
# create logbook entry
function log
{
    logbookPath=~/logbook

    if [ ! -e $logbookPath/token.txt ]
    then
        echo "No token file found."
        return
    fi

    machineToken=$(cat $logbookPath/token.txt)

    entryDate=$(date '+%Y-%m-%d')
    entryId=$(echo $machineToken$entryDate | md5sum | head -c 6)
    entryTitle=log-$entryDate-$entryId

    entry=$logbookPath/$entryTitle.md

    if [ ! -e $entry ]
    then
        echo new logbook entry
        echo "$entryTitle" > $entry
        echo "=====================" >> $entry
    fi

    vim $entry

    old_dir=$(pwd)
    cd $logbookPath
    git add $entry
    git commit -m"Automated logbook commit of entry $entryId"
    cd $old_dir
}


# search logbook for $1
function log-search
{
    logbookPath=~/logbook/
    grep -ir --exclude-dir=.git $1 $logbookPath
}

