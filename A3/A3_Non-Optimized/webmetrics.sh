#!/bin/bash

#print out the instruction
echo "Number of requests per web browser"

#check if the input file was given
if [[ $1 = "" ]]
then
	echo "Error: No log file given."
	echo "Usage: ./webmetrics.sh <logfile>"
	exit 1
fi

#check if the input is not a file
if [[ !(-f $1) ]]
then
	echo "Error: File '$1' does not exist."
	echo "Usage: ./webmetrics.sh <logfile>"
	exit 2
fi

file=$1
#number of requests of each explorer
s=$(grep -c 'Safari' $file)
f=$(grep -c 'Firefox' $file)
c=$(grep -c 'Chrome' $file)
echo "Safari,$s"
echo "Firefox,$f"
echo "Chrome,$c"
echo ''

#number of distinct user of each day
echo "Number of distinct users per day"
touch tmp.txt
touch result.txt
awk '
BEGIN{FS=" "}
{ print $4 }
' < $file > tmp.txt
awk '
BEGIN{FS=":"}
{ print $1 }
' < tmp.txt > r.txt
awk '
BEGIN{FS="["}
{ print $2 }
' < r.txt > result.txt
dd=$(sort -u result.txt)
rm tmp.txt
rm r.txt
rm result.txt
set $(echo $dd)
grep $1 $file > d1.txt
grep $2 $file > d2.txt
awk '{ print $1 }' < d1.txt > r1.txt
awk '{ print $1 }' < d2.txt > r2.txt
d1=$(sort -u r1.txt)
d2=$(sort -u r2.txt)
rm d1.txt d2.txt r1.txt r2.txt
c1=0
c2=0
for d in $d1
do
	c1=$(($c1+1))
done
for d in $d2
do
	c2=$(($c2+1))
done
echo "$1,$c1"
echo "$2,$c2"
echo ''

#Top20
echo "Top 20 popular product requests"
grep 'GET /product/*/*' $file > pattern.txt
awk '
BEGIN{ FS="/" } 
{ print $5 }
' < pattern.txt > roughID1.txt
grep '^[0-9]*[0-9]$' roughID1.txt > roughID2.txt
awk '
BEGIN{ FS=" " }
{ print $1$2 }
' < roughID2.txt > pureID.txt
rm pattern.txt roughID1.txt roughID2.txt
u=$(sort -u pureID.txt)
for id in $u
do
	count=$(grep -w -c $id pureID.txt)
	echo "$count $id" >> rank.txt
done
sort -rn rank.txt > r1.txt
rm rank.txt pureID.txt
sort -t $' ' -k 1nr,1 -k 2nr,2 r1.txt > r2.txt
head -n 20 r2.txt > r3.txt
awk ' { OFS="," ; print $2,$1 } ' < r3.txt > result.txt
cat result.txt
rm r1.txt r2.txt r3.txt result.txt
echo ''
exit 0
