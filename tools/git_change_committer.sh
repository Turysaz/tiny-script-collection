#!/bin/sh

# this script was copied from github.com

git filter-branch --env-filter '

OLD_EMAIL="old.email.address@private.mail"
CORRECT_NAME="Turysaz"
CORRECT_EMAIL="turysaz@users.noreply.github.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
	export GIT_COMMITTER_NAME="$CORRECT_NAME"
	export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi

if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
	export GIT_AUTHOR_NAME="$CORRECT_NAME"
	export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
