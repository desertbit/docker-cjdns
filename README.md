# Docker cjdns image

Installation is simple. On first run, cjdns will generate your IP
address. The cjdns configuration lies in `/etc/cjdns` (which is a
docker volume).

To be useful you'll have to run this in privileged mode, with the
same network stack as the host. This can be acomplished using the
docker options `--privileged --net=host`.

    docker pull desertbit/cjdns
    docker run -d --privileged --net=host --volume /data/cjdns:/etc/cjdns --name cjdns desertbit/cjdns
