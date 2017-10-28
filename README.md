# Docker cjdns image

Installation is simple. On first run, cjdns will generate your IP
address. The cjdns configuration lies in `/etc/cjdns` (which is a
docker volume).

    docker run -d -p hostPort:containerPort/udp --volume /data/cjdns:/etc/cjdns --name cjdns desertbit/cjdns

or

    docker run -d --privileged --net=host --volume /data/cjdns:/etc/cjdns --name cjdns desertbit/cjdns


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
ExecStartPre=/usr/bin/docker pull desertbit/cjdns
ExecStart=/usr/bin/docker run \
    -p hostPort:containerPort/udp \
    --volume /data/cjdns:/etc/cjdns \
    --name cjdns \
    desertbit/cjdns
ExecStop=/usr/bin/docker stop cjdns
```
