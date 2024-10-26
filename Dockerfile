FROM debian:stable as builder

MAINTAINER Roland Singer, roland.singer@desertbit.com

# Install dependencies.
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update -y && \
    apt upgrade -y && \
    apt install -y \
        build-essential \
        nodejs \
        git \
        python3 \
        rustc \
        cargo

# Install & build.
RUN export CJDNSTAG="cjdns-v22" && \
    git clone https://github.com/cjdelisle/cjdns.git /cjdns && \
    cd /cjdns && \
    git checkout "${CJDNSTAG}" && \
    RUSTFLAGS='-C target-cpu=x86-64 -C target-feature=+sse3,+avx' CROSS="true" ./cross-do

# Second Stage.
FROM debian:stable-slim

COPY --from=builder /cjdns/cjdroute /usr/bin/cjdroute
RUN mkdir -p /etc/cjdns

COPY entry.sh /entry.sh
VOLUME /etc/cjdns
ENTRYPOINT ["/bin/bash", "/entry.sh"]
CMD ["cjdroute", "--nobg"]
