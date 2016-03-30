FROM alpine
MAINTAINER Peter Mount <peter@retep.org>

# From https://github.com/rabbitmq/rabbitmq-server/releases
# Find rabbitmq-server-generic-unix-*.tar.xz file, eg:
#
#   https://github.com/rabbitmq/rabbitmq-server/releases/download/
#       rabbitmq_v3_7_0_milestone2/
#       rabbitmq-server-generic-unix-3.7.500.2.tar.xz
#
#   VERSION     3.7.500.2
#   MILESTONE   3.7.0_milestone2
#
# When released MILESTONE should match VERSION, e.g. 3.7.0
#
ENV         RABBITMQ_VERSION=3.7.500.2 \
            RABBITMQ_MILESTONE=3.7.0_milestone2

ENV         RABBITMQ_HOME=/opt/rabbitmq_server-${RABBITMQ_VERSION} \
            PLUGINS_DIR=${RABBITMQ_HOME}/plugins \
            ENABLED_PLUGINS_FILE=${RABBITMQ_HOME}/etc/rabbitmq/enabled_plugins \
            RABBITMQ_MNESIA_BASE=/var/lib/rabbitmq
ENV         PATH=$PATH:$RABBITMQ_HOME/sbin

COPY        ssl.config ${RABBITMQ_HOME}/etc/rabbitmq/
COPY        standard.config ${RABBITMQ_HOME}/etc/rabbitmq/
COPY        docker-entrypoint.sh /

EXPOSE      5671/tcp 5672/tcp 15672/tcp 15671/tcp
VOLUME      /var/lib/rabbitmq
ENTRYPOINT  ["/docker-entrypoint.sh"]
#CMD         ["/docker-entrypoint.sh"]

RUN         chmod a+x /docker-entrypoint.sh && apk add --update curl tar xz bash && \
            echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
            echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
            echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
            apk add erlang erlang erlang-mnesia erlang-public-key erlang-crypto erlang-ssl \
                erlang-sasl erlang-asn1 erlang-inets erlang-os-mon erlang-xmerl erlang-eldap \
                erlang-syntax-tools --update-cache --allow-untrusted && \
            cd /opt && \
            rmq_zip_url=https://github.com/rabbitmq/rabbitmq-server/releases/download && \
                rmq_zip_url=${rmq_zip_url}/rabbitmq_v$(echo $RABBITMQ_MILESTONE | tr '.' '_') && \
                rmq_zip_url=${rmq_zip_url}/rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.xz && \
            curl -L -o /opt/rmq.tar.xz $rmq_zip_url && \
            tar -xvf rmq.tar.xz && rm -f rmq.tar.xz && \
            ls -l /opt && \
            touch ${RABBITMQ_HOME}/etc/rabbitmq/enabled_plugins && \
            rabbitmq-plugins enable --offline \
                rabbitmq_management \
                rabbitmq_mqtt \
                rabbitmq_shovel \
                rabbitmq_shovel_management \
                rabbitmq_web_stomp &&\
            apk del --purge tar xz && rm -Rf /var/cache/apk/*

EXPOSE 15671 15672 \
        5672 \
        25672 \
        1883 \
        61613
