#!/bin/bash

. /config-jenkins.sh
. /config-docker.sh
. /config-maven.sh
. /config-ssh.sh

# Define NO_SSH=true to disable sshd
if [ -z "$NO_SSH" ]
then
    exec /usr/sbin/sshd -D -f /etc/ssh/sshd_config
fi
