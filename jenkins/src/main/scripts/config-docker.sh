#!/bin/ash

# If docker socket is present then ensure we have permission to access it
if [ -S /var/run/docker.sock ]
then
    gid=$(ls -ln /var/run/docker.sock | sed -re "s/ +/ /g" | cut -f4 -d' ')
    addgroup -g $gid docker 2>/dev/null
    gn=$(grep ":${gid}:" /etc/group|cut -f1 -d':')
    adduser root "$gn"
    adduser jenkins "$gn"
fi
