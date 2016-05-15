FROM area51/jenkins-slave:latest
MAINTAINER Peter Mount <peter@retep.org>

COPY motd /etc/motd

RUN ${alpine.repo} \
    apk add --update \
        alpine-sdk \
        autoconf \
        automake \
        cmake \
        cvs \
        git \
        mercurial \
        subversion \
        vim &&\
    ${alpine.repo.end} echo

# Don't remove apt lists as we want something present in most builds
#    ${alpine.repo.end} rm -rf /var/lib/apt/lists/*
