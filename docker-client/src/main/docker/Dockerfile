FROM area51/java:serverjre-8
MAINTAINER Peter Mount <peter@retep.org>

ENTRYPOINT  ["/bin/ash"]

RUN ${alpine.repo} \
    apk add --update ca-certificates openssh curl &&\
    echo Retrieving ${docker.version} &&\
    curl -sSL -O https://get.docker.com/builds/Linux/x86_64/${docker.version} &&\
    echo Installing ${docker.version} &&\
    tar zxf ${docker.version} -C / &&\
    ln -s /docker/docker /usr/bin/docker &&\
    rm -rf ${docker.version} /var/cache/apk/*
