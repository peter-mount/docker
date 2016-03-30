This is a docker image running rabbitmq

It has the following plugins enabled by default:
* rabbitmq_management
* rabbitmq_mqtt
* rabbitmq_shovel
* rabbitmq_shovel_management
* rabbitmq_web_stomp

# area51/rabbitmq:3.7.0m2
This is fresh image based on 3the .7.0 Milestone 2 release. As this is not a "stable" version you are advised to use 3.6 instead.

This image is now based around the Alpine linux base image to reduce it's footprint.

As the previous version you can define a few environment variables
* RABBITMQ_DEFAULT_USER the default user
* RABBITMQ_DEFAULT_PASS the default password

You can also persist the config as a volume, simply mount it on /var/lib/rabbitmq

For example:

   docker run -d --name rabbit --hostname rabbit \
        -e RABBITMQ_DEFAULT_USER=user \
        -e RABBITMQ_DEFAULT_PASS=password \
        -v /usr/local/rabbit:/var/lib/rabbitmq \
        area51/rabbitmq:3.7.0m2

IPv6 is supported automatically for the broker but the management plugin is only accessible on IPv4 at this time.

# area51/rabbitmq:3.6
This is based on the official rabbitmq image hence it's size.

