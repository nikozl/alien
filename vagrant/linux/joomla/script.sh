#! /bin/bash 

# FUTURO SCRIPT PARA INSTALAR UN ENTORNO LAMP Y CONFIGURAR JOOMLA =)
#SI TENEMOS PROXY LO EXPORTAMOS A /etc/environment y /etc/apt/apt.conf.d/30proxy

apt-get update -y
apt-get upgrade -y

apt-get install -y php7.0-mysql php7.0-curl php7.0-json php7.0-cgi php7.0 libapache2-mod-php7.0 php7.0-mcrypt

#PARA UBUNTU 16.04
apt-get install -y php7.0-simplexml
apt-get install -y php7.0-xml
systemctl restart apache2
