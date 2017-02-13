#!/bin/bash

sed -i 's/JENKINS_LISTEN_ADDRESS=""/JENKINS_LISTEN_ADDRESS="0.0.0.0"/g' /etc/sysconfig/jenkins
exec "$@"

