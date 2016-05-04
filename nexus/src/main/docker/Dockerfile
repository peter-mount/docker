FROM area51/java:serverjre-8
MAINTAINER Peter Mount <peter@retep.org>

ENV NEXUS_PORT 8081

ENV NEXUS_DATA ${nexus.work}

COPY *.sh /
#ENTRYPOINT  ["/docker-entrypoint.sh"]
CMD  ["/docker-entrypoint.sh"]

RUN mkdir -p /opt/sonatype ${nexus.work} &&\
    addgroup -g 1000 nexus &&\
    adduser -h ${nexus.work} \
    	    -u 1000 \
	    -G nexus \
	    -s /bin/false\
	    -D nexus &&\
    echo "Downloading Nexus ${nexus.version}" &&\
    curl -sSL -O ${nexus.url}/nexus-${nexus.version}-unix.tar.gz &&\
    echo "Installing Nexus ${nexus.version}" &&\
    tar xzf nexus-${nexus.version}-unix.tar.gz &&\
    mv nexus-${nexus.version} /opt/sonatype/nexus &&\
    rm -rf nexus-${nexus.version}-unix.tar.gz &&\
    chmod +x /*.sh &&\
    chown nexus:nexus /opt/sonatype -R &&\
    sed \
        -e "s|karaf.home=.|karaf.home=/opt/sonatype/nexus|g" \
        -e "s|karaf.base=.|karaf.base=/opt/sonatype/nexus|g" \
        -e "s|karaf.etc=etc|karaf.etc=/opt/sonatype/nexus/etc|g" \
        -e "s|java.util.logging.config.file=etc|java.util.logging.config.file=/opt/sonatype/nexus/etc|g" \
        -e "s|karaf.data=data|karaf.data=${NEXUS_DATA}|g" \
        -e "s|java.io.tmpdir=data/tmp|java.io.tmpdir=${NEXUS_DATA}/tmp|g" \
        -i /opt/sonatype/nexus/bin/nexus.vmoptions

VOLUME ${nexus.work}

WORKDIR /opt/sonatype/nexus
USER nexus

ENV CONTEXT_PATH /

ENV JAVA_MAX_MEM 1200m
ENV JAVA_MIN_MEM 256m

ENV EXTRA_JAVA_OPTS ""
#ENV EXTRA_JAVA_OPTS "-Djava.net.preferIPv4Stack=true"
