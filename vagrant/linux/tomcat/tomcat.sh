#! /bin/bash
export all_proxy="http://16.0.96.20:3128"
export http_proxy="http://16.0.96.20:3128"
export https_proxy="http://16.0.96.20:3128"
export no_proxy="127.0.0.1,16.0.0.0/8,172.28.0.0/16"
yum update -y
yum install wget -y
sleep 1
cd /opt/
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz"
tar xzf jdk-8u131-linux-x64.tar.gz
cd jdk1.8.0_131/
alternatives --install /usr/bin/java java /opt/jdk1.8.0_131/bin/java 2
alternatives --config java
alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_131/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_131/bin/javac 2
alternatives --set jar /opt/jdk1.8.0_131/bin/jar
alternatives --set javac /opt/jdk1.8.0_131/bin/javac

export JAVA_HOME=/opt/jdk1.8.0_131
export JRE_HOME=/opt/jdk1.8.0_131/jre
export PATH=$PATH:/opt/jdk1.8.0_131/bin:/opt/jdk1.8.0_131/jre/bin

cd /tmp
wget http://www.us.apache.org/dist/tomcat/tomcat-7/v7.0.79/bin/apache-tomcat-7.0.79.tar.gz
tar xzf apache-tomcat-7.0.79.tar.gz
mv apache-tomcat-7.0.79 /usr/local/tomcat7
cd /usr/local/tomcat7/
./bin/startup.sh


echo 'all_proxy="http://16.0.96.20:3128"' >> /etc/environment
echo 'http_proxy="http://16.0.96.20:3128"' >> /etc/environment
echo 'https_proxy="http://16.0.96.20:3128"' >> /etc/environment
echo 'no_proxy="127.0.0.1,16.0.0.0/8,172.28.0.0/16"' >> /etc/environment
echo "JAVA_HOME=/opt/jdk1.8.0_131" >> /etc/environment
echo "JRE_HOME=/opt/jdk1.8.0_131/jre" >> /etc/environment
echo "PATH=$PATH:/opt/jdk1.8.0_131/bin:/opt/jdk1.8.0_131/jre/bin" >> /etc/environment

echo "Reinicio maquina"|wall
reboot
