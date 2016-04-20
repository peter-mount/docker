FROM alpine
MAINTAINER Peter Mount <peter@retep.org>

ENV         RABBITMQ_VERSION=${rabbit.version} \
            RABBITMQ_MILESTONE=${rabbit.milestone}

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

RUN         ${alpine.repo} \
            chmod a+x /docker-entrypoint.sh && apk add --update curl tar xz bash && \
            echo "${alpine.url}/edge/main" >> /etc/apk/repositories && \
            echo "${alpine.url}/edge/testing" >> /etc/apk/repositories && \
            echo "${alpine.url}/edge/community" >> /etc/apk/repositories && \
            apk add erlang erlang erlang-mnesia erlang-public-key erlang-crypto erlang-ssl \
                erlang-sasl erlang-asn1 erlang-inets erlang-os-mon erlang-xmerl erlang-eldap \
                erlang-syntax-tools --update-cache --allow-untrusted && \
            cd /opt && \
            rmq_zip_url=${github.url} && \
                rmq_zip_url=${rmq_zip_url}/rabbitmq_v$(echo $RABBITMQ_MILESTONE | tr '.' '_') && \
                rmq_zip_url=${rmq_zip_url}/rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.xz && \
            curl -L -o /opt/rmq.tar.xz $rmq_zip_url && \
            tar -xvf rmq.tar.xz && rm -f rmq.tar.xz && \
            ls -l /opt && \
            touch ${RABBITMQ_HOME}/etc/rabbitmq/enabled_plugins && \
            rabbitmq-plugins enable --offline ${rabbit.plugins} &&\
            apk del --purge tar xz && rm -Rf /var/cache/apk/*

EXPOSE 15671 15672 \
        5672 \
        25672 \
        1883 \
        61613
