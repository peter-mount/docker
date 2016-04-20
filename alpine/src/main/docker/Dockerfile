################################################################################
# Base image for all of our Alpine based images.
#
################################################################################
FROM jeanblanchard/alpine-glibc
MAINTAINER Peter Mount <peter@retep.org>

RUN ${alpine.repo} \
    apk add --update curl &&\
    ${alpine.repo.end} rm -rf /var/cache/apk/*
