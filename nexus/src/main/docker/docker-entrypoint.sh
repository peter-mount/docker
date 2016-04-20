#!/bin/ash

exec /opt/jdk/bin/java \
    -Dnexus-work=${SONATYPE_WORK} \
    -Dnexus-webapp-context-path=${CONTEXT_PATH} \
    -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
    -cp 'conf/:lib/*' \
    ${JAVA_OPTS} \
    org.sonatype.nexus.bootstrap.Launcher ${LAUNCHER_CONF}
