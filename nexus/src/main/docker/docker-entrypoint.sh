#!/bin/ash

sed -i \
    -e "s|application-port=8081|application-port=${NEXUS_PORT}|g" \
    -e "s|nexus-context-path=/|nexus-context-path=${CONTEXT_PATH}|g" \
    /opt/sonatype/nexus/etc/org.sonatype.nexus.cfg

exec /opt/sonatype/nexus/bin/nexus run
