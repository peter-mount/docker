FROM area51/java:serverjre-8
MAINTAINER Peter Mount <peter@retep.org>

ENV SONATYPE_WORK ${nexus.work}

COPY *.sh /
#ENTRYPOINT  ["/docker-entrypoint.sh"]
ENTRYPOINT ["/bin/ash"]

RUN ${alpine.repo} \
    apk add --update ca-certificates curl &&\
    mkdir -p /opt/sonatype ${nexus.work} &&\
    addgroup -g 1000 nexus &&\
    adduser -h ${nexus.work} \
    	    -u 1000 \
	    -G nexus \
	    -s /bin/false\
	    -D nexus &&\
    echo "Downloading Nexus ${nexus.version}" &&\
    curl -sSL -O ${nexus.url}/nexus-${nexus.version}-bundle.tar.gz &&\
    tar xzf nexus-${nexus.version}-bundle.tar.gz &&\
    mv nexus-${nexus.version} /opt/sonatype &&\
    rm -rf nexus-${nexus.version}-bundle.tar.gz &&\
    ${alpine.repo.end} rm -rf /var/cache/apk/*

VOLUME ${nexus.work}

EXPOSE 8081
WORKDIR /opt/sonatype/nexus
USER nexus
ENV CONTEXT_PATH /
ENV MAX_HEAP 768m
ENV MIN_HEAP 256m
#ENV JAVA_OPTS -server -Djava.net.preferIPv4Stack=true
ENV JAVA_OPTS -server 
ENV LAUNCHER_CONF ./conf/jetty.xml ./conf/jetty-requestlog.xml
