#!/bin/bash

cd /opt/thingspeak

echo "Initialising environment"
(
    echo "development:"
    echo "  adapter: mysql2"
    echo "  encoding: utf8"
    echo "  reconnect: true"
    echo "  database: ${DB_NAME}"
    echo "  pool: ${DB_POOL}"
    echo "  username: ${DB_USER}"
    echo "  password: ${DB_PASSWORD}"
    echo "  host: ${DB_HOST}"
    echo "  port: ${DB_PORT}"
    echo "  min_messages: WARNING"
) >config/database.yml

echo "Booting thingspeak"

OPTS="${OPTS} -p ${HTTP_PORT}"

if [ "x$IPV6" != "xno" ]
then
    OPTS="${OPTS} -b ::"
fi

exec bundle exec rails server ${OPTS} 2>&1 >/dev/null
