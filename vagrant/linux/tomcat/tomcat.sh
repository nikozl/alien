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
#EXPORTAMOS VARIABLES JAVA
export JAVA_HOME=/opt/jdk1.8.0_131
export JRE_HOME=/opt/jdk1.8.0_131/jre
export PATH=$PATH:/opt/jdk1.8.0_131/bin:/opt/jdk1.8.0_131/jre/bin

cd /tmp
wget http://www.us.apache.org/dist/tomcat/tomcat-7/v7.0.81/bin/apache-tomcat-7.0.81.tar.gz ### ---> O la ultima version disponible 
tar xzf apache-tomcat-7.0.81.tar.gz
mv apache-tomcat-7.0.81 /usr/local/tomcat7

echo 'all_proxy="http://16.0.96.20:3128"' >> /etc/environment
echo 'http_proxy="http://16.0.96.20:3128"' >> /etc/environment
echo 'https_proxy="http://16.0.96.20:3128"' >> /etc/environment
echo 'no_proxy="127.0.0.1,16.0.0.0/8,172.28.0.0/16"' >> /etc/environment
echo "JAVA_HOME=/opt/jdk1.8.0_131" >> /etc/environment
echo "JRE_HOME=/opt/jdk1.8.0_131/jre" >> /etc/environment
echo "PATH=$PATH:/opt/jdk1.8.0_131/bin:/opt/jdk1.8.0_131/jre/bin" >> /etc/environment

yum install httpd -y
echo "LoadModule proxy_module /usr/lib64/httpd/modules/mod_proxy.so" >> /etc/httpd/conf/httpd.conf
echo "LoadModule proxy_http_module /usr/lib64/httpd/modules/mod_proxy_http.so" >> /etc/httpd/conf/httpd.conf
echo "include /etc/httpd/vhost.d/*.conf" >> /etc/httpd/conf/httpd.conf

hostnamectl set-hostname tomcatserver.local
mkdir -p /etc/httpd/vhost.d
touch /etc/httpd/vhost.d/00-tomcat-niko.conf
cat > /etc/httpd/vhost.d/00-tomcat-niko.conf << EOF
<VirtualHost *:80>
  Servername tomcatserver.local
  ProxyPass / http://172.28.128.3:8080/
  ProxyPassReverse / http://172.28.128.3:80
  ProxyPreserveHost On
  ProxyRequests Off
</VirtualHost>
EOF
#DISABLE SELINUX 
setenforce 0
#sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/sysconfig/selinux
#reboot
cd /usr/local/tomcat7
systemctl start httpd
./bin/catalina.sh start
