#!/bin/bash

# multigit, the multi-repo committer and pusher
#
# Copyright (C) 2016 by Turysaz
#
# THE almost unmodified BEER-WARE LICENSE 
# ========================================
# Turysaz wrote this software. As long as you retain the
# copyright notice above and this notice you can do what-
# ever you want with it. If we meet some day and you think,
# this tool is worth it, you can buy me a beer in return.
# Have a nice day! Turysaz
#
# (The original beer-ware license was written by Poul-
# Henning Kamp. Special thanks to him for the idea!

echo ""
echo "this is multigit, the multi-repo git syncer"
echo ""
echo "Copyright (c) 2016 by Turysaz"
echo "published under the beer-ware license"

for i in *
do
	if [ -e "$i/.git" ]; then
		echo "$i is a git repository"
		echo "status:"
		# git repo found
		cd $i
		git status
		
		# prompts
		echo ""

		read -p "shall changes be committed? [Y/n]" _commit
		_commit=${_commit:-Y}
		#TODO if _commit != Y or n

		if [[ $_commit == "Y" ]]
		then
			git commit -a -m"auto-commit by multigit"
		else
			read -p "shall changes be discarded? [y/N]" _discard
			_discard=${_discard:-N}

			if [[ $_discard == "y" ]]
			then
				echo "discarding uncommitted changes in $i"
				git checkout -f
			fi
		fi

		read -p "shall changes be pushed? [Y/n]" _push
		_push=${_push:-Y}

		if [[ $_push == "Y" ]]
		then
			git push
		fi

		cd ..
	else
		# no git repo found
		echo "$i is NO git repository."
	fi
done
