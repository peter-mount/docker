FROM area51/ubuntu-dev:latest
MAINTAINER Peter Mount <peter@retep.org>

RUN apt-get update &&\
    groupadd --gid 1000 jenkins &&\
    useradd --home-dir /home/jenkins \
            --gid 1000 --uid 1000 \
            --create-home \
            --password jenkins \
            jenkins &&\
    rm -rf /var/lib/apt/lists/*
