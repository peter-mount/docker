#!/bin/ash

for i in \
    area51/alpine \
    area51/java:serverjre-8 \
    area51/java:jre-8 \
    area51/java:jdk-8 \
    area51/docker-client:latest \
    area51/jenkins-slave:latest \
    area51/jenkins:latest \
    area51/alpine-dev:latest \
    area51/debian-dev:latest \
    area51/ubuntu-dev:latest \
    area51/nexus:latest \
    area51/rabbitmq:latest \
    area51/postgresql:latest \
    area51/postgis:latest \
    area51/thingspeak:latest
do
    echo
    echo $i
    docker push $i
done
