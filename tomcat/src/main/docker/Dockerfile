FROM area51/java:serverjre-8
MAINTAINER Peter Mount <peter@retep.org>

ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.32
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

ENV POSTGRESQL_VERSION 9.4.1208
ENV POSTGRESQL_URL http://central.maven.org/maven2/org/postgresql/postgresql/$POSTGRESQL_VERSION/postgresql-$POSTGRESQL_VERSION.jar

# adding address=127.0.0.1 to server.xml prevents shutdown port from being accessed externally by port scanners - from experience :-(

WORKDIR /opt

RUN apk add --update curl &&\
    echo "Downloading $TOMCAT_TGZ_URL" &&\
    curl -sfSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz &&\
    tar -xvzpf tomcat.tar.gz &&\
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat &&\
    sed -e "s/^<Server /<Server address=\"127.0.0.1\" /" -i /opt/tomcat/conf/server.xml &&\
    curl "$POSTGRESQL_URL" -o /opt/tomcat/lib/postgresql-${POSTGRESQL_VERSION}.jar &&\
    rm -rf \
        tomcat/bin/*.bat \
        tomcat/temp/safeToDelete.tmp \
        tomcat/R* \
        tomcat/webapps/ROOT \
        tomcat/webapps/docs \
        tomcat/webapps/examples \
        tomcat.tar.gz* &&\
    apk del curl &&\
    rm -rf /var/cache/apk/*

EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

