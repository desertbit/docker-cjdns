FROM alpine

RUN apk add --no-cache \
    cjdns

RUN mkdir -p /etc/cjdns

COPY entry.sh /entry.sh
VOLUME /etc/cjdns
ENTRYPOINT ["/bin/sh", "/entry.sh"]
CMD ["cjdroute", "--nobg"]
