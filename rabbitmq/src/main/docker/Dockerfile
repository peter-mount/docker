FROM rabbitmq
MAINTAINER Peter Mount <peter@retep.org>

RUN rabbitmq-plugins enable --offline \
        rabbitmq_management \
        rabbitmq_mqtt \
        rabbitmq_shovel \
        rabbitmq_shovel_management \
        rabbitmq_web_stomp

EXPOSE 15671 15672 \
        5672 \
        25672 \
        1883 \
        61613
