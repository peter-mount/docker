FROM ubuntu:16.04
MAINTAINER Peter Mount <peter@retep.org>

# Java Version - Based on jeanblanchard/jdk
ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 92
ENV JAVA_VERSION_BUILD 14
ENV JAVA_PACKAGE       jdk

RUN ${ubuntu.repo} \
    mkdir -p /var/run/sshd /opt &&\
    apt-get update &&\
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        aufs-tools \
        autoconf \
        automake \
        build-essential \
        curl libcurl4-openssl-dev \
        cvs \
        git \
        mercurial \
        openssh-server \
        reprepro \
        s3cmd \
        subversion \
        sudo \
        unzip \
        vim \
        zip

RUN echo "Downloading java ${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}" &&\
    curl -s -jkLH "Cookie: oraclelicense=accept-securebackup-cookie" -o java.tar.gz\
        ${java.download.url}/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz &&\
    echo "Installing java ${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}" &&\
    gunzip -c java.tar.gz | tar -xf - -C /opt &&\
    rm -f java.tar.gz &&\
    ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk &&\
    ln -s /opt/jdk/bin/idlj /usr/local/bin/idlj &&\
    ln -s /opt/jdk/bin/jar /usr/local/bin/jar &&\
    ln -s /opt/jdk/bin/jarsigner /usr/local/bin/jarsigner &&\
    ln -s /opt/jdk/bin/java /usr/local/bin/java &&\
    ln -s /opt/jdk/bin/java-rmi.cgi /usr/local/bin/java-rmi.cgi &&\
    ln -s /opt/jdk/bin/javac /usr/local/bin/javac &&\
    ln -s /opt/jdk/bin/javadoc /usr/local/bin/javadoc &&\
    ln -s /opt/jdk/bin/javah /usr/local/bin/javah &&\
    ln -s /opt/jdk/bin/javap /usr/local/bin/javap &&\
    ln -s /opt/jdk/bin/jcmd /usr/local/bin/jcmd &&\
    ln -s /opt/jdk/bin/jdb /usr/local/bin/jdb &&\
    ln -s /opt/jdk/bin/jdeps /usr/local/bin/jdeps &&\
    ln -s /opt/jdk/bin/jhat /usr/local/bin/jhat &&\
    ln -s /opt/jdk/bin/jinfo /usr/local/bin/jinfo &&\
    ln -s /opt/jdk/bin/jjs /usr/local/bin/jjs &&\
    ln -s /opt/jdk/bin/jmap /usr/local/bin/jmap &&\
    ln -s /opt/jdk/bin/jmc /usr/local/bin/jmc &&\
    ln -s /opt/jdk/bin/jps /usr/local/bin/jps &&\
    ln -s /opt/jdk/bin/jrunscript /usr/local/bin/jrunscript &&\
    ln -s /opt/jdk/bin/jsadebugd /usr/local/bin/jsadebugd &&\
    ln -s /opt/jdk/bin/jstack /usr/local/bin/jstack &&\
    ln -s /opt/jdk/bin/jstat /usr/local/bin/jstat &&\
    ln -s /opt/jdk/bin/jstatd /usr/local/bin/jstatd &&\
    ln -s /opt/jdk/bin/keytool /usr/local/bin/keytool &&\
    ln -s /opt/jdk/bin/native2ascii /usr/local/bin/native2ascii &&\
    echo "Stripping cruft from JDK" &&\
    rm -rf /opt/jdk/*src.zip \
         /opt/jdk/lib/missioncontrol \
         /opt/jdk/lib/visualvm \
         /opt/jdk/lib/*javafx* \
         /opt/jdk/jre/lib/plugin.jar \
         /opt/jdk/jre/lib/ext/jfxrt.jar \
         /opt/jdk/jre/bin/javaws \
         /opt/jdk/jre/lib/javaws.jar \
         /opt/jdk/jre/lib/desktop \
         /opt/jdk/jre/plugin \
         /opt/jdk/jre/lib/deploy* \
         /opt/jdk/jre/lib/*javafx* \
         /opt/jdk/jre/lib/*jfx* \
         /opt/jdk/jre/lib/amd64/libdecora_sse.so \
         /opt/jdk/jre/lib/amd64/libprism_*.so \
         /opt/jdk/jre/lib/amd64/libfxplugins.so \
         /opt/jdk/jre/lib/amd64/libglass.so \
         /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
         /opt/jdk/jre/lib/amd64/libjavafx*.so \
         /opt/jdk/jre/lib/amd64/libjfx*.so &&\
    echo "Patching cacerts for LetsEncrypt support" &&\
    curl -s ${letsencrypt.repo}/lets-encrypt-x1-cross-signed.pem -o /lets-encrypt-x1-cross-signed.pem &&\
    curl -s ${letsencrypt.repo}/lets-encrypt-x2-cross-signed.pem -o /lets-encrypt-x2-cross-signed.pem &&\
    curl -s ${letsencrypt.repo}/lets-encrypt-x3-cross-signed.pem -o /lets-encrypt-x3-cross-signed.pem &&\
    curl -s ${letsencrypt.repo}/lets-encrypt-x4-cross-signed.pem -o /lets-encrypt-x4-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x1-cross-signed -file /lets-encrypt-x1-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x2-cross-signed -file /lets-encrypt-x2-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x3-cross-signed -file /lets-encrypt-x3-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x4-cross-signed -file /lets-encrypt-x4-cross-signed.pem &&\
    rm -f /*.pem

# Create jenkins user with default password (overridable when creating the image).
# Allow sudo for build jobs to install packages required at build time
COPY        motd        /etc/motd
COPY        ssh_host_*  /etc/ssh.cache/
COPY        *.sh        /

# Copy to /etc/ssh/ as ubuntu seems to create random keys at install time, ssh.cache to keep inline with shared /config-ssh.sh script
COPY        ssh_host_*  /etc/ssh/

ENTRYPOINT  ["/docker-entrypoint.sh"]
RUN groupadd --gid 1000 jenkins &&\
    useradd --gid 1000 --uid 1000 -s /bin/bash -d /home/jenkins -m jenkins &&\
    echo "jenkins:jenkins" | chpasswd &&\
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers &&\
    chmod 400 /etc/ssh/*_key /etc/ssh.cache/*_key &&\
    chmod +x /*.sh

# Don't clean up apt as we can use that as part of dev build jobs later otherwise they'll need to run apt-get update each time
#    echo "Cleaning up" &&\
#    ${ubuntu.repo.end} rm -rf /var/lib/apt/lists/*
