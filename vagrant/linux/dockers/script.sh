#! /bin/bash

#EXPORT DE PROXY (EN CASO DE TENERLO)
export all_proxy="http://16.0.96.20:3128"
export http_proxy="http://16.0.96.20:3128"
export https_proxy="http://16.0.96.20:3128"
export no_proxy="127.0.0.1,16.0.0.0/8,172.28.0.0/16"

apt-get update -y
apt-get install -y curl

#AÑADIMOS LA CLAVE Y EL REPOSITORIO OFICIAL
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'

#INSTALAMOS Y HABILITAMOS DOCKER
apt-get update -y
apt-cache policy docker-engine >> desdedondeinstalamos
apt-get install -y docker-engine
systemctl enable docker
systemctl start docker

#CAMBIAMOS EL HOSTNAME DE LA MAQUINA
hostnamectl set-hostname docker --static
sed -i "4a 172.28.128.3   docker.nik.local  docker" /etc/hosts

