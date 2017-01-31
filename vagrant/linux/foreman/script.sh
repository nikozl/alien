#! /bin/bash

###--------------------------------------------------------------------------------------------------###
### SCRIPT PARA CREAR UNA INFRAESTRUCTURA FOREMAN/PUPPET QUE PERMITA HACER INSTALACIONES PXE POR RED ###
###--------------------------------------------------------------------------------------------------###

#EXPORTAMOS PROXY EN CASO DE TENERLO
export all_proxy="http://16.0.96.20:3128"
export http_proxy="http://16.0.96.20:3128"
export https_proxy="http://16.0.96.20:3128"
export no_proxy="127.0.0.1,16.0.0.0/8,172.28.0.0/16" 

#DESACTIVAMOS EL FW POR DEFECTO EN CENTOS 7
setenforce 0

# SI PARTIMOS DE UNA MINIMAL ISO DEBEREMOS INSTALAR ALGUNOS PAQUETES EXTRA
yum install -y net-tools
yum install -y git
yum groupinstall -y "Development Tools"
#yum update -y

#HABILITAMOS LOS REPOSITORIOS
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum -y install epel-release http://yum.theforeman.org/releases/1.11/el7/x86_64/foreman-release.rpm

#ASIGNAMOS HOSTNAME Y FQDN
echo "172.28.128.5 foremantest.example.local foremantest" >> /etc/hosts
echo "foremantest" > /etc/hostname

#ANTES DE EJECUTAR EL INSTALADOR DE FOREMAN
yum install -y ruby193-rubygem-foreman_setup ruby193-rubygem-foreman_bootdisk genisoimage ipxe-bootimgs
#INSTALAMOS EL INSTALADOR DE FOREMAN
yum install foreman-installer -y
foreman-installer

#INSTALAMOS SERVICIO DHCP
yum install -y dhcpd

#EDITAMOS EL FICHERO DE CONFIGURACION
echo "ddns-update-style interim;" >> /etc/dhcp/dhcpd.conf
echo "ignore client-updates;" >> /etc/dhcp/dhcpd.conf
echo "authoritative;" >> /etc/dhcp/dhcpd.conf
echo "allow booting;" >> /etc/dhcp/dhcpd.conf
echo "allow bootp;" >> /etc/dhcp/dhcpd.conf
echo "allow unknown-clients;" >> /etc/dhcp/dhcpd.conf
echo "subnet 172.28.128.0 netmask 255.255.255.0 {" >> /etc/dhcp/dhcpd.conf
echo "range 172.28.128.10 172.28.128.254;" >> /etc/dhcp/dhcpd.conf
echo "option domain-name-servers 172.28.128.1;" >> /etc/dhcp/dhcpd.conf
echo "option domain-name "example.local";" >> /etc/dhcp/dhcpd.conf
echo "option routers 172.28.128.1;" >> /etc/dhcp/dhcpd.conf
echo "option broadcast-address 172.28.128.255;" >> /etc/dhcp/dhcpd.conf
echo "default-lease-time 600;" >> /etc/dhcp/dhcpd.conf
echo "max-lease-time 7200;" >> /etc/dhcp/dhcpd.conf
echo "next-server 172.28.128.5;" >> /etc/dhcp/dhcpd.conf
echo "filename "pxelinux.0";" >> /etc/dhcp/dhcpd.conf
echo "}" >> /etc/dhcp/dhcpd.conf

#REINICIAMOS EL SERVICIO
service	dhcpd restart

#CAMBIAMOS EL PUERTO POR DEFECTO DE PUPPETMASTER EN LOS FICHEROS DE APACHE YA QUE ES QUIEN LO EJECUTARA A PARTIR DE AHORA
cd /root
git clone https://github.com/nikozl/alien
mv /root/alien/foreman/puppet/000-default-puppetmaster.conf /etc/httpd/conf.d/000-default-puppetmaster.conf

#PONEMOS NUESTRO FQDN EN EL FICHERO DE CONFIGURACION DE PUPPET
sed -i "7a server = foremantest.example.local" /etc/puppet/puppet.conf
sed -i "8a certname = foremantest.example.local" /etc/puppet/puppet.conf


#INSTALAMOS TFTPBOOT
yum install tftp-server syslinux system-config-kickstart -y 

#EDIATAMOS EL FICHERO DE CONFIGURACION SI ES NECESARIO

#REINICIAMOS LOS SERVICIOS
service xinetd restart
service tftp restart

#COPIAMOS ARCHIVOS Y CAMBIAMOS PROPIETARIOS NECESARIOS

###cd /usr/share/syslinux/
###cp -a pxelinux.0 menu.c32 memdisk mboot.c32 chain.c32 /var/lib/tftpboot/
###cd /root/predator/foreman
###cp -a boot pxelinux.cfg /var/lib/tftpboot/
###cd /var/lib/tftpboot 
###chown foreman-proxy:foreman-proxy *

#yum upgrade -y
#REINICIAMOS EL SISTEMA
yum upgrade -y
sleep 5 
echo "Reiniciando sistema..."
sleep 5
reboot
