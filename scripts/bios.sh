#! /bin/bash

#set -e
#set -x

ip=(16.137.49.11 36.140.49.8)

version() {
version=$(/usr/bin/sshpass -p "mmtel" ssh -o StrictHostKeyChecking=no root@$i ''dmidecode |grep -2 BIOS |grep Version |awk '{print $2}' '')
}

hostname() {
hostname=$(/usr/bin/sshpass -p "mmtel" ssh -o StrictHostKeyChecking=no root@$i 'hostname')
}

pintar() {
echo "$hostname, $version"
}

main() {
for i in ${ip[@]};
do

version
hostname
pintar


#/usr/bin/sshpass -p "mmtel" ssh -o StrictHostKeyChecking=no root@$i ''dmidecode |grep -2 BIOS |grep Version |awk '{print $2}' '' >> niko.csv 

done
}

main "$@"
