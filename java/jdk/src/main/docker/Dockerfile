################################################################################
# Based on jeanblanchard/java by Jean Blanchard <jean@blanchard.io>
#
# This generates a custom image with the following additions:
# 1: The letsencrypt CA is added to the certificates. Required if you want to
#    use https to a server using that CA. This will be removed once Oracle add
#    it to the jdk.
#
################################################################################
FROM jeanblanchard/java:jdk-8
MAINTAINER Peter Mount <peter@retep.org>

# Download and add the pem to the trust store
RUN apk add --update curl &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.pem -o /le.pem &&\
    keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -file /le.pem &&\
    rm -f /le.pem && \
    apk del curl &&\
    rm -rf /var/cache/apk/*
