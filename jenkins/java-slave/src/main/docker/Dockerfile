FROM area51/docker-client
MAINTAINER Peter Mount <peter@retep.org>

ENV JENKINS_HOME /home/jenkins

COPY motd /etc/motd
COPY ssh_host_* /etc/ssh.cache/

COPY docker-entrypoint.sh /
ENTRYPOINT  ["/docker-entrypoint.sh"]

RUN addgroup -g 1000 jenkins &&\
    adduser -h ${JENKINS_HOME} \
    	    -u 1000 \
	    -G jenkins \
	    -s /bin/ash \
	    -D jenkins &&\
    echo "jenkins:${jenkins.password}" | chpasswd &&\
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers &&\
    addgroup -g 1001 cloud &&\
    adduser -h /home/cloud \
    	    -u 1001 \
	    -G cloud \
	    -s /bin/ash \
	    -D cloud &&\
    echo "cloud:${jenkins.password}" | chpasswd &&\
    echo "cloud ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

RUN ${alpine.repo} \
    chmod 500 /docker-entrypoint.sh &&\
    chmod -f 600 /etc/ssh.cache/ssh_host_* &&\
    mkdir -p ~root/.ssh &&\
    chmod 700 ~root/.ssh/ &&\
    echo -e "Port 22\n" >> /etc/ssh/sshd_config &&\
    cp -a /etc/ssh /etc/ssh.cache && \
    mkdir -p /var/run/sshd &&\
    apk add --update \
        git \
        mercurial \
        subversion &&\
    ${alpine.repo.end} rm -rf /var/cache/apk/*

EXPOSE 22/tcp

VOLUME ${JENKINS_HOME}
