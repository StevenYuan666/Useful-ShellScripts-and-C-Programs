#!/bin/bash


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
#print out the instruction
echo "Number of requests per web browser"
s=$(grep -c 'Safari' $file)
f=$(grep -c 'Firefox' $file)
c=$(grep -c 'Chrome' $file)
echo "Safari,$s"
echo "Firefox,$f"
echo "Chrome,$c"
echo ''

#number of distinct user of each day
echo "Number of distinct users per day"
awk 'BEGIN{FS=":"}{ print $1 }' < $file > r.txt
awk 'BEGIN{FS="["}{ print $2 }' < r.txt > result.txt
dd=$(sort -u result.txt)
rm r.txt result.txt
for d in $dd
do 
	grep $d $file > d1.txt
	awk '{ print $1 }' < d1.txt > r1.txt
	d1=($(sort -u r1.txt))
	c1=${#d1[@]}
	rm d1.txt r1.txt
	echo "$d,$c1"
done
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
