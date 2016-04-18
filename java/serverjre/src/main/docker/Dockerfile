################################################################################
# Based on jeanblanchard/java by Jean Blanchard <jean@blanchard.io>
#
# This generates a custom image with the following additions:
# 1: The letsencrypt CA is added to the certificates. Required if you want to
#    use https to a server using that CA. This will be removed once Oracle add
#    it to the jdk.
#
################################################################################
FROM jeanblanchard/java:serverjre-8
MAINTAINER Peter Mount <peter@retep.org>

# Download and add the pem to the trust store
RUN apk add --update curl &&\
    sed -e "s|export PATH=|export PATH=/opt/jdk/bin:|" -i /etc/profile &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.pem -o /lets-encrypt-x1-cross-signed.pem &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x2-cross-signed.pem -o /lets-encrypt-x2-cross-signed.pem &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem -o /lets-encrypt-x3-cross-signed.pem &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x4-cross-signed.pem -o /lets-encrypt-x4-cross-signed.pem &&\
    keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x1-cross-signed -file /lets-encrypt-x1-cross-signed.pem &&\
    keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x2-cross-signed -file /lets-encrypt-x2-cross-signed.pem &&\
    keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x3-cross-signed -file /lets-encrypt-x3-cross-signed.pem &&\
    keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x4-cross-signed -file /lets-encrypt-x4-cross-signed.pem &&\
    rm -f /*.pem && \
    apk del curl &&\
    rm -rf /var/cache/apk/*
