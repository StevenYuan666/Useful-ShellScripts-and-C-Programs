#!/bin/bash

#check if the user input two arguments
if [[ $# -ne 2 ]]
then
	echo "Error: Expected two input parameters."
	echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
	exit 1
fi

#check if the directories or files are exist
if [[ !(-d $1) ]]
then
	echo "Error: Backup directory '$1' does not exist."
	echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
	exit 2
elif [[ !((-d $2) || (-f $2)) ]]
then
	if [[ $2 = *\.* ]]
	then
		echo "Error: The file '$2' does not exist"
		echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
        	exit 2
	else
		echo "Error: The directory '$2' does not exist"
                echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
                exit 2
	fi
fi
if [[ "$1" = "$2" ]]
then
	echo "Error: The two input directories are same"
	echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
        exit 2
fi

d=$(date +%Y%m%d)
dest=$1
f=$2
b=$(basename $f)
nn="$b.$d.tar"

if [[ !(-f "$dest/$nn") ]]
then
	tar -cf $dest/$nn $f 2> /dev/null
	exit 0
else
	echo -n "Backup file '$dest/$nn' already exists. Overwrite? (y/n)"
        read ans
        if [[ $ans = y ]]
        then
		tar -cf $dest/$nn $f 2> /dev/null
		exit 0
	else
		echo "Error: File already exists. Not overwriting."
                exit 3
        fi
fi
