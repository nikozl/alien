#! /bin/bash

export all_proxy="http://16.0.96.20:3128"
export http_proxy="http://16.0.96.20:3128"
export https_proxy="http://16.0.96.20:3128"
export no_proxy="127.0.0.1,16.0.0.0/8,172.28.0.0/16"

#PREPARAMOS LA INSTALACION
yum install -y vim
yum install -y wget

#IMPORTAMOS REPO
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key

#INSTALAMOS JAVA Y JENKINS
yum install -y jenkins java-1.7.0-openjdk

#HABILITAMOS E INICIAMOS JENKINS
systemctl start jenkins
systemctl enable jenkins

#ABRIMOS PUERTOS DEL FIREWALL
firewall-cmd --start
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload

#MODIFICAMOS CONFIGURACION PARA PODER ACCEDER A JENKINS
sed -i 's/JENKINS_LISTEN_ADDRESS=""/JENKINS_LISTEN_ADDRESS="0.0.0.0"/g' /etc/sysconfig/jenkins

#CAMBIAMOS EL HOSTNAME DE LA MAQUINA
hostnamectl set-hostname jenkins --static
