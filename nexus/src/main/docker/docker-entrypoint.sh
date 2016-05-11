#!/bin/ash

sed -i \
    -e "s|application-port=8081|application-port=${NEXUS_PORT}|g" \
    -e "s|nexus-context-path=/|nexus-context-path=${CONTEXT_PATH}|g" \
    /opt/sonatype/nexus/etc/org.sonatype.nexus.cfg

# Enable IPv6 support?
if [ -n "$IPv6" ]
then
    VMOPTS=/opt/sonatype/nexus/bin/nexus.vmoptions
    cp $VMOPTS /tmp/.vm
    grep -v "java.net.preferIPv4Stack" /tmp/.vm >$VMOPTS
fi

exec /opt/sonatype/nexus/bin/nexus run
