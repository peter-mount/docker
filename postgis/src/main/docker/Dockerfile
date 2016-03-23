FROM postgres:9.5
MAINTAINER Peter Mount <peter@retep.org>

ENV POSTGIS_MAJOR 2.2
ENV POSTGIS_VERSION 2.2.1+dfsg-2.pgdg80+1

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
        vim \
        postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
        postgis=$POSTGIS_VERSION &&\
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./*.sh /docker-entrypoint-initdb.d/