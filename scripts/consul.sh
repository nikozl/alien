#! /bin/bash
#set -e
#set -x

datos=($(curl http://16.0.96.20:8500/v1/kv/pctce?keys 2>/dev/null |cut -d "["  --output-delimiter=" " -f 1- |cut -d "]"  --output-delimiter=" " -f 1- |cut -d ","  --output-delimiter=" " -f 1- |cut -d '"'  --output-delimiter=" " -f 1-))


main () {
for i in "${datos[@]}" ;
do
cambio=${i/\//\, }
cambio2=${cambio/\//\, }
hostname=${cambio2#* }
hostname2=$(printf '%s\n' "${hostname%%,*}")
rebuild=$(curl http://16.0.96.20:8500/v1/kv/pctce/"${hostname2}"/rebuild?raw 2>/dev/null)
diskless=$(curl http://16.0.96.20:8500/v1/kv/pctce/"${hostname2}"/diskless?raw 2>/dev/null)
 if [[ $rebuild == "" ]]; then
 rebuild="false"
 fi
 if [[ $diskless == "" ]]; then
 diskless="false"
 fi
echo "$hostname2,$rebuild,$diskless"
done
}

main"$@"

