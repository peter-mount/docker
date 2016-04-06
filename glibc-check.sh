#!/bin/bash
#
# Generate a report of current glibc versiion in each container
#
# Written to check this to see if CWE-121: Stack-based Buffer Overflow - CVE-2015-7547 is fixed in each image
#
# http://www.kb.cert.org/vuls/id/457759
###########################################################################
VER=/tmp/ver$$
FMT="%10s %20s %16s %s\n"

function runtest() {
    printf "$FMT" \
	$(echo $1|cut -f1 -d'/') \
	$(echo $1|cut -f2 -d'/'|cut -f1 -d':') \
	$(echo $1|cut -f2 -d':') \
	$(docker run -it --rm $1 $2 2>/dev/null| head -1 | sed -r -e "s/^.* version (.+?),.+$/\1/g")
}

printf "$FMT" "Project" "Image" "Version" "glibc version"
echo "==========================================================================="

# Alpine based containers
for IMAGE in area51/java:serverjre-8 \
    area51/java:jre-8 \
    area51/java:jdk-8 \
    area51/fileserver:latest \
    area51/job-controller:latest \
    area51/job-docker:latest \
    area51/mapgenerator:latest
do
    runtest $IMAGE /usr/glibc-compat/lib/libc.so.6
done
#
# Can't test rabbit this way
#    area51/rabbitmq:latest \
#    area51/rabbitmq:3.7.0m2


# Ubuntu based containers
for IMAGE in area51/ubuntu-dev:latest \
    area51/ubuntu-dev:16.04 \
    area51/postgis:latest \
    area51/postgis:9.5
do
    runtest $IMAGE /lib/x86_64-linux-gnu/libc.so.6
done

