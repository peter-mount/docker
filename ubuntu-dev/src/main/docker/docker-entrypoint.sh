#!/bin/bash
#
# Environment variables:
# MAVEN_MIRROR          The url of a local repository to use instead of maven central
# MAVEN_PRIVATE_MIRROR  Optional when MAVEN_MIRROR is in use, a secondary mirror
#
# JNLP Slave:
# ===========
# JENKINS_URL           Url to the Jenkins server
# JENKINS_SECRET        Secret key
#
# SSH Slave:
# ==========
# JENKINS_PASSWORD      Optional, the password for the Jenkins user
#

. /config-jenkins.sh
. /config-docker.sh
. /config-maven.sh
. /config-ssh.sh

if [ -n "$JENKINS_URL" ]
then
    CMD="/opt/jdk/jre/bin/java -jar /opt/slave.jar"
    CMD="$CMD -jnlpUrl '${JENKINS_URL}/computer/$(hostname)/slave-agent.jnlp'"
    CMD="$CMD -secret '${JENKINS_SECRET}'"
    wget -O /opt/slave.jar ${JENKINS_URL}/jnlpJars/slave.jar && exec su -c "$CMD" - jenkins
else
    exec /usr/sbin/sshd -D -f /etc/ssh/sshd_config
fi
