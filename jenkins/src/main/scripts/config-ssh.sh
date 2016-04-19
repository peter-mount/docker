#!/bin/ash
# SSH Slave:
# ==========
# JENKINS_PASSWORD      Optional, the password for the Jenkins user
#

# Copy default config from cache
if [ ! "$(ls -A /etc/ssh)" ]; then
   cp -a /etc/ssh.cache/* /etc/ssh/
fi

# If no ssh keys, copy again
if ! ls /etc/ssh/ssh_host_* 1> /dev/null 2>&1; then
   cp -a /etc/ssh.cache/ssh_host_* /etc/ssh/
fi

# Generate Host keys, if required
if ! ls /etc/ssh/ssh_host_* 1> /dev/null 2>&1; then
    ssh-keygen -A
fi

# Set the jenkins password
if [ -n "$JENKINS_PASSWORD" ]
then
    echo "jenkins:${JENKINS_PASSWORD}" | chpasswd
fi