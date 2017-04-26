#! /bin/bash

a=0
b=1
echo -n "Enter a Number :"
read Num
for (( i=0;i<=Num;i++ ));
do
let s=$a+$b
echo "$a"
a=$b
b=$s
done

