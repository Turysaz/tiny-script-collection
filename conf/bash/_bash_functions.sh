
function __log-id
{
    entryDate=$1
    machineToken=$2
    echo $(echo $machineToken$entryDate | md5sum | head -c 6)
}

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

    entryId=$(__log-id $entryDate $machineToken)

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
    git pull --no-ff origin master
    cd $old_dir
}

# get a two-byte random hex number
function randhex
{
    echo $RANDOM | xargs printf "%04x"
}


# resolve init
__conflicts-init() {
    # read the names of all unmerged files into the array _CONFLICTS
    readarray -t _CONFLICTS < <(git diff --name-only --diff-filter=U)
}

# list all conflicts
conflicts-list() {
    __conflicts-init

    max=${#_CONFLICTS[@]}
    if [[ $max -le 0 ]]
    then
        echo "No conflicting files known."
        return
    fi

    for i in `seq 0 $(($max - 1))`
    do
        printf '%i: %s\n' $i ${_CONFLICTS[$i]}
    done
}

# open file with conflicts
conflicts-edit() {
    re='^[0-9]+$'

    __conflicts-init

    if [[ ${#_CONFLICTS[@]} -le 0 ]]
    then
        echo "No conflicting files known."
        return
    fi

    if [[ -z $1 ]]
    then
        echo "Please specify the file's index."
        echo "(Run 'conflicts-list' to get a list.)"
        return
    fi

    if [[ ! $1 =~ $re || $1 -ge ${#_CONFLICTS[@]} || $1 -lt 0 ]]
    then
        echo "Invalid index: '$1'"
        return
    fi

    vim "${_CONFLICTS[$1]}"
}

# open file with conflicts
conflicts-add() {
    re='^[0-9]+$'

    __conflicts-init

    if [[ ${#_CONFLICTS[@]} -le 0 ]]
    then
        echo "No conflicting files known."
        return
    fi

    if [[ -z $1 ]]
    then
        echo "Please specify the file's index."
        echo "(Run 'conflicts-list' to get a list.)"
        return
    fi

    if [[ ! $1 =~ $re || $1 -ge ${#_CONFLICTS[@]} || $1 -lt 0 ]]
    then
        echo "Invalid index: '$1'"
        return
    fi

    read -p "Stage '${_CONFLICTS[$1]}'? [yN]" _answer

    [[ $_answer != "y" ]] && return

    git add "${_CONFLICTS[$1]}"
}

