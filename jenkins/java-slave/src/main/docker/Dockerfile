FROM area51/java:serverjre-8
MAINTAINER Peter Mount <peter@retep.org>

COPY motd /etc/motd
COPY ssh_host_* /etc/ssh.cache/

COPY docker-entrypoint.sh /
ENTRYPOINT  ["/docker-entrypoint.sh"]

RUN apk add --update ca-certificates openssh curl &&\
    chmod 500 /docker-entrypoint.sh &&\
    chmod -f 600 /etc/ssh.cache/ssh_host_* &&\
    mkdir -p ~root/.ssh &&\
    chmod 700 ~root/.ssh/ &&\
    echo -e "Port 22\n" >> /etc/ssh/sshd_config &&\
    cp -a /etc/ssh /etc/ssh.cache && \
    mkdir -p /var/run/sshd &&\
    addgroup -g 1000 jenkins &&\
    adduser -h /home/jenkins \
    	    -u 1000 \
	    -G jenkins \
	    -s /bin/ash \
	    -D jenkins &&\
    echo "jenkins:${jenkins.password}" | chpasswd &&\
    apk add --update \
        git \
        mercurial \
        subversion &&\
    echo Retrieving ${docker.version} &&\
    curl -sSL -O https://get.docker.com/builds/Linux/x86_64/${docker.version} &&\
    echo Installing ${docker.version} &&\
    tar zxf ${docker.version} -C / &&\
    rm -rf ${docker.version} /var/cache/apk/*

EXPOSE 22

