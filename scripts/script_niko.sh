#! /bin/bash

#set -x
#set -e

ip() {
#/usr/bin/rsh $i '' /sbin/ifconfig | grep 'addr:' | awk '{print $2}' | cut -d ':' -f2 ''
#/usr/bin/rsh $i '' /sbin/ifconfig | grep 'addr:' | cut -d ':' -f2 | awk '{print $1}' '' >> niko.txt
#ip=$(/usr/bin/rsh $i ' /sbin/ifconfig | grep 'inet' | cut -d ":" -f2 | cut -d " " -f1 | grep "[^127.0.0.1]" | tr "\n" "|" ')
ip=$(/usr/bin/rsh $i ' /sbin/ifconfig | grep 'inet' | cut -d ":" -f2 | cut -d " " -f1 | grep "[^127.0.0.1]"')
}


mac() {
#/usr/bin/rsh $i '' /sbin/ifconfig |grep 'HWaddr' | awk '{print $5}' ''
mac=$(/usr/bin/rsh $i ''/sbin/ifconfig |grep 'HWaddr'|awk '{print $5}' '')

}


sistema() {
sistema=$(/usr/bin/rsh $i ''cat /etc/issue |grep "[^\]"'')
}


ram() {
ram=$(/usr/bin/rsh $i ''free -m | grep Mem | awk '{print $2}''')
}


megafonia() {
megafonia=$(/usr/bin/rsh $i 'cat /home/siv/sistema/V/CfgEquipo.CFG |grep CONTROL_MEGAFONIA ')
}

bios() {
bios=$(/usr/bin/rsh $i ' cat /sys/devices/virtual/dmi/id/bios_version' )


}
pintar() {
#  printf "$i,"
#  printf "$ip,"
#  printf "$sistema,"
#  printf "$ram,"
#  printf "$mac"
#  printf "\n"

#   echo "$i, $ip, $sistema, $ram, $mac"
   echo "$i, $megafonia"
#   printf "\n"
}

main() {
#hosts=$(awk '{print $2}' /home/siv/sistema/V/Router.Now)
hosts=$(awk '{print $4}' /home/siv/sistema/V/CfgConfig.CFG.bck)
for i in ${hosts[@]} ; do
#  ip
#  mac
#  sistema
#  ram
  megafonia
  #bios
  pintar
done
}

main"$@"

