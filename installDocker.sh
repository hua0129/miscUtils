#!/bin/bash


yum -y remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum-config-manager --enable docker-ce-nightly

yum-config-manager --enable docker-ce-test
yum -y install docker-ce docker-ce-cli containerd.io

systemctl start docker

docker run hello-world
