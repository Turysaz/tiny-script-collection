
# create logbook entry
function log
{
    logbookPath=~/logbook

    if [ ! -e $logbookPath/token.txt ]
    then
        echo "No token file found."
        echo "Please add a 'token.txt' file containing a machine-specific"
        echo "random text line to your logbook dir."
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

function log-view
{
    logbookPath=~/logbook/
    old_dir=$(pwd)
    token=$1

    cd $logbookPath
    result=$(ls | grep $token | head -n 1)

    if [[ $result == "" ]]; then
        echo "No matching entry found"
        cd $old_dir
        return
    fi

    echo $result

    less <$result

    cd $old_dir
}

# push to master
function log-push
{
    logbookPath=~/logbook/
    old_dir=$(pwd)
    cd $logbookPath
    git push origin master
    cd $old_dir
}

# pull from master
function log-pull
{
    logbookPath=~/logbook/
    old_dir=$(pwd)
    cd $logbookPath
    git pull origin master
    cd $old_dir
}

# get a two-byte random hex number
function randhex
{
    echo $RANDOM | xargs printf "%04x"
}

