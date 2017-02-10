FROM centos

RUN yum update
RUN DEBIAN_FRONTEND=noninteractive apt-get install jenkins -y

CMD ["systemctl","start","jenkins.service"]
