# docker
A collection of Docker image builds used elsewhere in other projects

## Java
Based on [jeanblanchard/java](https://hub.docker.com/r/jeanblanchard/java/) by Jean Blanchard this is a set of three docker images with any custom additions we require added, usually features or configuration not present in the default JDK.

At this moment in time the additions are:
1. The [LetsEncrypt CA](https://letsencrypt.org/) is added to the certificates. Required if you want to use https to a server using that CA. This will be removed once Oracle add it to the jdk.
