#! /bin/bash

#set -e
#set -x

datos=( $(curl --silent http://16.0.96.20:8500/v1/kv/pctce?keys | awk 'FS="/" {print $2}' | uniq) )

main () {
echo "hostname,rebuild,diskless,fecha,version"
for i in "${datos[@]}" ;
do
hostname=$i
rebuild=$(curl http://16.0.96.20:8500/v1/kv/pctce/"${hostname}"/rebuild?raw 2>/dev/null)
diskless=$(curl http://16.0.96.20:8500/v1/kv/pctce/"${hostname}"/diskless?raw 2>/dev/null)
fecha=$(curl http://16.0.96.20:8500/v1/kv/pctce/"${hostname}"/fecha?raw 2>/dev/null)
version=$(curl http://16.0.96.20:8500/v1/kv/pctce/"${hostname}"/version?raw 2>/dev/null)
 if [[ $rebuild == "" ]]; then
 rebuild="false"
 fi
 if [[ $diskless == "" ]]; then
 diskless="false"
 fi
 if [[ $fecha == "" ]]; then
 fecha="error"
 fi
 if [[ $version == "" ]]; then
 version="error"
 fi
echo "$hostname,$rebuild,$diskless,$fecha,$version"
done
}

main"$@"

