# Docker cjdns image

Installation is simple. On first run, cjdns will generate your IP
address. The cjdns configuration lies in `/etc/cjdns` (which is a
docker volume).

    docker run --rm -d -p HOST_PORT:CONTAINER_PORT/udp --cap-add=NET_ADMIN --device=/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 --volume /data/cjdns:/etc/cjdns --name cjdns desertbit/cjdns

## Systemd Service

```
[Unit]
Description=cjdns
After=docker.service
Requires=docker.service

[Install]
WantedBy=multi-user.target

[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker kill cjdns
ExecStartPre=-/usr/bin/docker rm cjdns
ExecStartPre=-/usr/bin/docker pull desertbit/cjdns
ExecStart=/usr/bin/docker run \
    --volume /data/cjdns:/etc/cjdns \
    --name cjdns \
    -p HOST_PORT:CONTAINER_PORT/udp \
    --cap-add=NET_ADMIN --device=/dev/net/tun \
    --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    desertbit/cjdns
ExecStop=/usr/bin/docker kill cjdns
```