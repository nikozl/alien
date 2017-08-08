#! /bin/bash

export all_proxy="http://16.0.96.20:3128"
export http_proxy="http://16.0.96.20:3128"
export https_proxy="http://16.0.96.20:3128"
export no_proxy="127.0.0.1,16.0.0.0/8,172.28.0.0/16"

sudo apt-get update -y
sudo apt-get install apache2 -y
sudo mkdir /root/nikopacker
