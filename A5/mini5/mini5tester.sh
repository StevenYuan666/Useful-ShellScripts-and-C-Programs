#!/bin/bash
echo
echo '----------START THE TESTER OF MINI ASSIGNMENT 5----------'

echo
#check if compile correctly
echo '$ gcc -o report report.c'
gcc -o report report.c
result=$?
echo '$ echo $?'
echo $result

echo
#check question7
echo '$ ./report data.csv'
./report data.csv
result=$?
echo '$ echo $?'
echo $result

echo
#check question8
echo '$  ./report nosuchdata.csv "Jane Doe" rpt.txt'
./report nosuchdata.csv "Jane Doe" rpt.txt
result=$?
echo '$ echo $?'
echo $result

echo
#check question9
echo '$ ./report data.csv "Jane Doe" rpt.txt'
./report data.csv "Jane Doe" rpt.txt
result=$?
echo '$ echo $?'
echo $result

echo
#check question10
echo '$ ./report data.csv "Markus Bender" rpt.txt'
if [[ -f rpt.txt ]]
then
	chmod -rwx rpt.txt
fi
./report data.csv "Markus Bender" rpt.txt
result=$?
echo '$ echo $?'
echo $result
chmod +rwx rpt.txt

echo
#check question11
echo '$ ./report data.csv "Markus Bender" rpt.txt'
./report data.csv "Markus Bender" rpt.txt
result=$?
echo '$ echo $?'
echo $result
echo '$ cat rpt.txt'
cat rpt.txt

echo
#check question12
echo '$ ./report data.csv "Adaline Murphy" rpt.txt'
./report data.csv "Adaline Murphy" rpt.txt
result=$?
echo '$ echo $?'
echo $result
echo '$ cat rpt.txt'
cat rpt.txt

echo
echo '----------COMPLETED THE TESTER FOR MINI ASSIGNMENT 5----------'





