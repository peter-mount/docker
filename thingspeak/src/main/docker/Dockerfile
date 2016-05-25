FROM ruby:2.1
MAINTAINER Peter Mount <peter@retep.org>

ENV DEBIAN_FRONTEND noninteractive

ENV DB_POOL         5
ENV DB_USER         thingspeak
ENV DB_PASSWORD     thingspeak
ENV DB_HOST         thingspeak
ENV DB_PORT         5432
ENV HTTP_PORT       80

WORKDIR /opt/

COPY docker-entrypoint.sh /

RUN ${debian.repo} \
    apt-get update &&\
    apt-get install -y \
        build-essential \
        git \
        libpq-dev \
        postgresql-client &&\
    mkdir -p /opt &&\
    cd /opt &&\
    git clone https://github.com/peter-mount/thingspeak.git &&\
    cd thingspeak &&\
    echo "gem 'pg'" >>Gemfile &&\
    bundle install &&\
    chmod +x /*.sh &&\
    ${debian.repo.end} rm -rf /var/lib/apt/lists/*

WORKDIR /opt/thingspeak/

#EXPOSE 80

CMD '/docker-entrypoint.sh'
