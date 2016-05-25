#!/bin/bash

cd /opt/thingspeak

DB_NAME=development
echo "Initialising environment"
(
    echo "${DB_NAME}:"
    echo "  adapter: postgresql"
    echo "  encoding: unicode"
    echo "  database: ${env}"
    echo "  pool: ${DB_POOL}"
    echo "  username: ${DB_USER}"
    echo "  password: ${DB_PASSWORD}"
    echo "  host: ${DB_HOST}"
    echo "  port: ${DB_PORT}"
    echo "  min_messages: WARNING"
) >config/database.yml

echo "pgpass"
(
    for DB in postgres ${DB_NAME}
    do
        echo "${DB_HOST}:${DB_PORT}:${DB}:${DB_USER}:${DB_PASSWORD}"
    done
) >~/.pgpass
chmod 0400 ~/.pgpass

echo "Checking database"
psql -h ${DB_HOST} -U ${DB_USER} ${DB_NAME} -c "" || (
    echo "Initialising database"
    rake db:create
    rake db:schema:load
)

echo "Booting thingspeak"
exec bundle exec rails server -p ${HTTP_PORT}
