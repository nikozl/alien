
#! /bin/bash
clear
echo "---- BASIC BASH SCANPORT ----";
echo "=================================";
echo -n "WHAT DO YOU WANT TO SCAN? :";
read dir;
echo -n "initial port : ";
read ip;
echo -n "final port : ";
read fp;

for ((contar=$ip; contar<=$fp; contar++))
do
(echo > /dev/tcp/$dir/$contar) > /dev/null 2>&1 && echo "(*) OPEN [$contar]";
done





