ARG BASE_IMAGE="ubuntu:22.04"
FROM $BASE_IMAGE AS base_image

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    iptables \
    strongswan \
    strongswan-pki \
    libcharon-extra-plugins \
    libcharon-extauth-plugins \
    libstrongswan-extra-plugins \
    libtss2-tcti-tabrmd0

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mv -f /etc/sysctl.conf /etc/sysctl.conf.original && \
    mv -f /etc/ipsec.conf /etc/ipsec.conf.original && \
    mv -f /etc/ipsec.secrets /etc/ipsec.secrets.original

COPY root/ /

RUN chmod 755 /usr/local/bin/docker-entrypoint && \
    chmod 755 /usr/local/sbin/set-iptables && \
    chmod 644 /etc/sysctl.conf && \
    chmod 644 /etc/ipsec.conf

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD bash -c 'echo >/dev/udp/127.0.0.1/500 >/dev/null 2>&1'

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["docker-entrypoint"]
