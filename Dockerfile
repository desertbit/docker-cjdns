FROM debian:stable as builder

MAINTAINER Roland Singer, roland.singer@desertbit.com

# Install dependencies.
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y nodejs git build-essential python2.7

# Install & build.
RUN export CJDNSTAG="cjdns-v20.7" && \
    git clone https://github.com/cjdelisle/cjdns.git /cjdns && \
    cd /cjdns && \
    git checkout "${CJDNSTAG}" && \
    ./do

# Second Stage.
FROM debian:stable

COPY --from=builder /cjdns/cjdroute /usr/bin/cjdroute
RUN mkdir -p /etc/cjdns

COPY entry.sh /entry.sh
VOLUME /etc/cjdns
ENTRYPOINT ["/bin/bash", "/entry.sh"]
CMD ["cjdroute", "--nobg"]