#! /bin/bash

set -x
#set -e

ip() {
/usr/bin/rsh $i 'ip a || ifconfig'
}

sistema() {
/usr/bin/rsh $i 'cat /etc/issue'
}

ram() {
#echo $i;/usr/bin/rsh $i 'free -m |awk '{print $1}''
/usr/bin/rsh $i 'free -m || cat /proc/meminfo |grep MemTotal'
}

megafonia() {
/usr/bin/rsh $i 'cat /home/metro/sistema/V/CfgEquipo.CFG '
}

main() {
hosts=$(awk '{print $2}' /home/siv/sistema/V/Router.Now)
for i in ${hosts[@]} ; do
	echo "$i"
	ip
	sistema
	ram
	megafonia
done
}

main"$@"

