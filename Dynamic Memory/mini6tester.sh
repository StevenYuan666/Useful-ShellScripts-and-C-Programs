#!/bin/bash
### WARNING !!!!! STUDENTS MUST NOT CHANGE/EDIT THIS FILE !!!
### You might accidentally delete/change your files or change the intention of the test case
###   if you make changes to this sript without understanding the consequences.
### This script is intended to be executed in mimi using the bash shell.

check_for_source()
{
    if [[ ! -f "$1" ]]
    then
        echo "Source file '$1' not found. Stopping now. Make sure all files are in the same folder as $(basename $0)."
        exit 1;
    fi
}

print_and_run()
{
    echo "\$ $1"
    bash -c "$1" 2>&1
    echo -e "exit code: $?"
}

check_for_source "wcloud.c"
check_for_source "wordlist.c"
check_for_source "wordlist.h"
if [[ ! -f "Makefile" ]] && [[ ! -f "makefile" ]]
then
    echo "Makefile not found. Stopping now. Make sure all files are in the same folder as $(basename $0)."
    exit 1;
fi


# BEGIN SETUP
sourcedir=$PWD
tmpdir=/tmp/__tmp_comp206_${LOGNAME}
mkdir -p "$tmpdir"
cp *.c *.h [mM]akefile "$tmpdir"
cd "$tmpdir"

# Create test files
cat - <<EOF > adams2004.txt
Bayesian approach describe how stimulus
is combined with prior knowledge

Prior kwowledge is learned in response to
environment
EOF

cat - <<EOF > girshick2011.txt
In Bayesian ApproacH prior knowledge is learned
from environment.

Prior knowledge is like environment statistics
EOF

cat - <<EOF > gardner2019.txt
Is prior knowledge combined with stimulus like in
Bayesian approach
How is prior knowledge combined with stimulus
Is brain Bayesian
EOF

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  wcloud tests @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

echo
echo "[[[[ test case 0: run make (all files compiled; wcloud created) ]]]]"
echo "********************************************************************************************"
print_and_run "make"
print_and_run "ls -1"
echo "********************************************************************************************"
echo 
echo "[[[[ test case 1: run make (no changes)]]]]"
echo "********************************************************************************************"
print_and_run "make"
echo "********************************************************************************************"
echo
echo "[[[[ test case 2: update wordlist.c, run make (wordlist.o and wcloud recompiled) ]]]]"
echo "********************************************************************************************"
print_and_run "touch wordlist.c; make"
echo "********************************************************************************************"
echo
echo "[[[[ test case 3: update wordlist.h, run make (wcloud.o, wcloud, and wordlist.o) ]]]]"
echo "********************************************************************************************"
print_and_run "touch wordlist.h; make"
echo "********************************************************************************************"
echo 
echo "[[[[ test case 3: update wordlist.h, run make (wcloud.o and wcloud recompiled) ]]]]"
echo "********************************************************************************************"
print_and_run "touch wcloud.c; make"
echo "********************************************************************************************"
echo
echo "[[[[ test case 5: EXPECTED TO FAIL - usage ]]]]"
echo "********************************************************************************************"
print_and_run "./wcloud"
echo "********************************************************************************************"
echo
echo "[[[[ test case 6: EXPECTED TO FAIL - file does not exist ]]]]"
echo "********************************************************************************************"
print_and_run "./wcloud /this_file_does_not_exist"
echo "********************************************************************************************"
echo
echo "[[[[ test case 7: EXPECTED TO WORK - 1 article ]]]]"
echo "********************************************************************************************"
print_and_run "./wcloud adams2004.txt"
echo "********************************************************************************************"
echo
echo "[[[[ test case 8: EXPECTED TO WORK - 3 articles ]]]]"
echo "********************************************************************************************"
print_and_run "./wcloud adams2004.txt girshick2011.txt gardner2019.txt"
echo "********************************************************************************************"
echo
echo "[[[[ test case 9: EXPECTED TO WORK WITH ERROR MESSAGE - 3 articles, 1 does not exist ]]]]"
echo "********************************************************************************************"
print_and_run "./wcloud /this_file_does_not_exist girshick2011.txt gardner2019.txt"
echo "********************************************************************************************"
echo


# CLEAN UP
rm -r "$tmpdir"
