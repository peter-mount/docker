FROM area51/docker-client
MAINTAINER Peter Mount <peter@retep.org>

ENV JENKINS_HOME /home/jenkins

COPY motd /etc/motd
COPY ssh_host_* /etc/ssh.cache/

COPY *.sh /
ENTRYPOINT  ["/docker-entrypoint.sh"]

RUN ${alpine.repo} \
    apk add --update ca-certificates openssh curl &&\
    chmod 500 /docker-entrypoint.sh &&\
    chmod -f 600 /etc/ssh.cache/ssh_host_* &&\
    mkdir -p ~root/.ssh &&\
    chmod 700 ~root/.ssh/ &&\
    echo -e "Port 22\n" >> /etc/ssh/sshd_config &&\
    cp -a /etc/ssh /etc/ssh.cache && \
    mkdir -p /var/run/sshd &&\
    addgroup -g 1000 jenkins &&\
    adduser -h ${JENKINS_HOME} \
    	    -u 1000 \
	    -G jenkins \
	    -s /bin/ash \
	    -D jenkins &&\
    echo "jenkins:${jenkins.password}" | chpasswd &&\
    apk add --update \
        git \
        mercurial \
        subversion &&\
    rm -rf /var/cache/apk/*

EXPOSE 22/tcp

VOLUME ${JENKINS_HOME}
