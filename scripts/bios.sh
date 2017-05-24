#! /bin/bash

#set -e
#set -x

ip=()

version() {
version=$(/usr/bin/sshpass -p "mmtel" ssh -o StrictHostKeyChecking=no siv@$i ''dmesg | grep -i intel | awk '{print $5}' | head -1'')
if [[ $version == "supported." ]] ; then 
 version=$(/usr/bin/sshpass -p "mmtel" ssh -o StrictHostKeyChecking=no siv@$i ''dmesg |grep -2 -i ACPI: |grep RSDT |awk '{print $4}' '')
elif [[ $version == "D865PERL" ]] ; then
 version="RL86510A"
elif [[ $version == "D845PESV" ]] ; then
 version="SV84510A"
elif [[ $version == "D845HV" ]] ; then
 version="HV84510A"
fi
}

hostname() {
hostname=$(/usr/bin/sshpass -p "mmtel" ssh -o StrictHostKeyChecking=no siv@$i 'hostname')
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

done
}

main "$@"
