# area51/postgis

This image provides a Docker container running with PostgreSQL 9.5 and PostGIS 2.2 installed. It's based on the official [`postgres`](https://registry.hub.docker.com/_/postgres/) image.

## Usage

To run a new instance, start a container as follows:

    docker run --name postgis -e POSTGRES_PASSWORD=password -d area51/postgis

You can then use a normal postgresql client to access it.

To get it's address:

    docker inspect --format '{{ .NetworkSettings.IPAddress }}' postgis

This will return an IPv4 address:

    172.17.4.84

Then you can connect to it with:

    psql -h 172.17.4.84 -U postgres

If you are using IPv6 you can use the following to get at the ip address:

    docker inspect --format '{{ .NetworkSettings.GlobalIPv6Address }}' postgis

This will return something like 2001:DB8::242:ac11:454

## Advanced networking

When you run it you can add additional entries into pg_hba.conf to allow external networks access. By default we add the local docker network to this but you can add more.

To add more, simply include the POSTGRES_NETWORK environment variable, so to add the 2001:DB8:1234/48 network then we would use:

    docker run --name postgis -e POSTGRES_PASSWORD=password -e POSTGRES_NETWORK="2001:DB8:1234/48" -d area51/postgis

You can add more to this, just separate them with spaces. You can add IPv4 addresses here as well:

    docker run --name postgis -e POSTGRES_PASSWORD=password -e POSTGRES_NETWORK="2001:DB8:1234/48 192.168.1.0/24 2001:DB8:9999:1212/64" -d area51/postgis

This will then add 3 networks to the pg_hba.conf file.
