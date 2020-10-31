#!/bin/bash

#check if there are two inputs
if [[ $# -ne 2 ]]
then
	echo "Error: Expected two input parameters."
	echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
	exit 1
fi
#check if the two inputs are fine
if [[ !(-d $1) ]]
then
	echo "Error: Input parameter #1 '$1' is not a directory."
	echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
	exit 2
elif [[ !(-d $2) ]]
then
	echo "Error: Input parameter #2 '$2' is not a directory."
        echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
        exit 2
elif [[ $1 = $2 ]]
then
	echo "Error: Input parameter #1 '$1' and #2 '$2' are same directory"
	echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
	exit 2
fi
#define a function
#declare variables
ff(){
	f1=$(ls $1)
	f2=$(ls $2)
	r="Store the result"
	for f in $f1
	do
		if [[ $(find $2 -name $f) = "" ]]
		then
			#if there is a / in the end of $2, then will not add / again
			if [[ $2 =~ /$ ]]
			then
				echo "$2$f is missing"
			else
				echo "$2/$f is missing"
			fi
			r=""
		elif [[ $(diff $1/$f $2/$f) != "" ]]
		then
			#if there is a / in the end of $1, then will not add / again
			if [[ $1 =~ /$ ]]
			then
				echo "$1$f differs"
			else
				echo "$1/$f differs"
			fi
			r=""
		fi
	done
	for f in $f2
	do
		if [[ $(find $1 -name $f) = "" ]]
		then
			#if there is a / in the end of $1, then will not add / again
			if [[ $1 =~ /$ ]]
			then
				echo "$1$f is missing"
			else
				echo "$1/$f is missing"
			fi
			r=""
		fi
	done
	if [[ $r = "" ]]
	then
		return 3
	else
		return 0
	fi
}
#call the function
ff $1 $2
if [[ $? -eq 3 ]]
then
	exit 3
else
	exit 0
fi






