#!/bin/bash
for i in \
        area51/alpine \
	area51/java:serverjre-8 \
	area51/java:jre-8 \
	area51/java:jdk-8 \
	area51/docker-client:latest \
	area51/jenkins-slave:latest \
	area51/jenkins:latest \
	area51/fileserver:latest \
	area51/kernel:latest-opendata \
	area51/kernel:latest \
	area51/ubuntu-dev:latest \
	area51/rabbitmq:latest \
	area51/postgis:latest
do
	docker push $i
done

