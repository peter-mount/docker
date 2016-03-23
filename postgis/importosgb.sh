#!/bin/bash
#############################################################
# Imports the OSGB data into a new database
#
#  For first dvd: ./importosgb.sh -d
# For other dvds: ./importosgb.sh -a
#############################################################


# -d to create a new table, -a to append to an existing table
f="$1"
if [ -z "$f" ]
then
    f="-d"
fi

# Where the shape file directories are located.
# Each subdirectory maps to an OSGB map sheet, e.g. TQ
MOUNT=/media/peter/data

# Configure these accordingly:
HOST=postgis-hostname
USER=postgres
DB=osgb
# Ensure you have ~/.pgpass configured:
# postgis-hostname:5432:osgb:postgres:password

# OSGB Coordinate System
EPSG=27700

# PostGIS geometry field name
GEOM=geometry

# Temp file/directory for sql
SQL=/tmp/sql

if [ $f == '-d' ]
then
    echo '##################################################'
    echo "## Creating database $DB"
    echo '##################################################'
    psql -e -h $HOST -U $USER <<EOF
DROP DATABASE $DB;
CREATE DATABASE $DB WITH ENCODING 'UTF-8';
EOF
    psql -e -h $HOST -U $USER $DB <<EOF
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
EOF
fi

# Ensure tables exist, ok for this to fail
echo '##################################################'
echo '## Ensuring tables exist'
echo '##################################################'
mkdir -p $SQL
(
    for shp in $MOUNT/*/*.shp
    do
	table=$(basename $shp .shp | cut -c4-)
	if [ ! -f $SQL/$table ]
	then
	    shp2pgsql -s $EPSG -p -g $GEOM $shp $table >$SQL/$table
	fi
    done
    for sql in $SQL/*
    do
	psql -e -h $HOST -U $USER $DB -f $sql
    done
) >/dev/null 2>&1
rm -rf $SQL

# The tiles to import
for i in $MOUNT/*
do
    (
	cd $i
	echo '##################################################'
	echo "## Importing $(pwd)"
	echo '##################################################'
	for shp in *.shp
	do
	    table=$(basename $shp .shp|cut -c4-)
	    echo
	    echo $table
	    echo '--------------------'
	    psql -h $HOST -U $USER $DB -f $SQL
	    done
    )
    f="-a"
done

echo '##################################################'
echo '## DVD now imported'
echo '##################################################'
