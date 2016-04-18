#!/bin/ash
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

# /opt/jenkins is available for the workspace work files
if [ ! -d /opt/jenkins ]
then
    mkdir -p /opt/jenkins
    chown jenkins:jenkins /opt/jenkins
fi

# Maven config
if [ ! -f /home/jenkins/.m2/settings.xml ]
then
    mkdir -p /home/jenkins/.m2
    (
	echo '<?xml version="1.0" encoding="UTF-8"?>'
	echo '<settings xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">'
	
	if [ -n "$MAVEN_MIRROR" ]
	then
	    MIRROR_OF=central
	    if [ -n "$MAVEN_PRIVATE_MIRROR" ]
	    then
		MIRROR_OF="${MIRROR_OF},!localMirror"
	    fi
	    echo '<mirrors>'
	    echo "<mirror><id>centralMirror</id><name>Local mirror of central</name><url>${MAVEN_MIRROR}</url><mirrorOf>${MIRROR_OF}</mirrorOf></mirror>"
	    echo '</mirrors>'

	    echo '<profiles>'
	    echo '<profile><id>centralMirror</id>'
	    echo '<repositories>'
	    echo '<repository><id>central</id><url>http://central</url><releases><enabled>true</enabled></releases><snapshots><enabled>true</enabled></snapshots></repository>'
	    if [ -n "$MAVEN_PRIVATE_MIRROR" ]
	    then
		echo "<repository><id>privateMirror</id><url>${MAVEN_PRIVATE_MIRROR}</url><releases><enabled>true</enabled></releases><snapshots><enabled>true</enabled></snapshots></repository>"
	    fi
	    echo '</repositories>'
	    echo '<pluginRepositories>'
	    echo '<pluginRepository><id>central</id><url>http://central</url><releases><enabled>true</enabled></releases><snapshots><enabled>true</enabled></snapshots></pluginRepository>'
	    if [ -n "$MAVEN_PRIVATE_MIRROR" ]
	    then
		echo "<pluginRepository><id>privateMirror</id><url>${MAVEN_PRIVATE_MIRROR}</url><releases><enabled>true</enabled></releases><snapshots><enabled>true</enabled></snapshots></pluginRepository>"
	    fi
	    echo '</pluginRepositories>'
	    echo '</profile>'
	    echo '</profiles>'
	    echo '<activeProfiles><activeProfile>centralMirror</activeProfile></activeProfiles>'
	fi
	echo '</settings>'
    ) >/home/jenkins/.m2/settings.xml
    chown -R jenkins:jenkins /home/jenkins/.m2
fi

if [ -n "$JENKINS_URL" ]
then
    CMD="/opt/jdk/jre/bin/java -jar /opt/slave.jar"
    CMD="$CMD -jnlpUrl '${JENKINS_URL}/computer/$(hostname)/slave-agent.jnlp'"
    CMD="$CMD -secret '${JENKINS_SECRET}'"
    wget -O /opt/slave.jar ${JENKINS_URL}/jnlpJars/slave.jar && exec su -c "$CMD" - jenkins
else

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

    exec /usr/sbin/sshd -D -f /etc/ssh/sshd_config
fi
