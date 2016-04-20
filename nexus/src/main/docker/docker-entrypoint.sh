#!/bin/ash

sed -i -e "s/application-port=8081/application-port=${NEXUS_PORT}/g" /opt/sonatype/nexus/conf/nexus.properties

exec /opt/jdk/bin/java \
    -Dnexus-work=${SONATYPE_WORK} \
    -Dnexus-webapp-context-path=${CONTEXT_PATH} \
    -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
    -cp 'conf/:lib/*' \
    ${JAVA_OPTS} \
    org.sonatype.nexus.bootstrap.Launcher ${LAUNCHER_CONF}
