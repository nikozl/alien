FROM centos

ENV http_proxy='http://16.0.96.20:3128'
ENV https_proxy='http://16.0.96.20:3128'
RUN yum update -y
RUN yum install wget -y
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo
RUN rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN yum install -y jenkins java-1.7.0-openjdk

#CMD ["systemctl start jenkins.service","-D","FOREGROUND"]
