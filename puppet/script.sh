#! /bin/bash

set -x

export http_proxy="http://16.0.96.20:3128"
export https_proxy="http://16.0.96.20:3128"
export no_proxy="16.2.96.21"

rpm -ivh --httpproxy 16.0.96.20 --httpport 3128 http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum install -y puppet

echo "192.168.33.10 nik.puppet.local" >> /etc/hosts


echo "Estamos terminando la configuracion..."

sleep 1

sed -i "5a server = nik.puppet.local" /etc/puppet/puppet.conf

puppet agent -t


