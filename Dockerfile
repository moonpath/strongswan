ARG BASE_IMAGE="alpine:latest"
FROM $BASE_IMAGE AS runtime

ARG DEBIAN_FRONTEND=noninteractive

RUN apk add --no-cache \
    iptables \
    strongswan \
    tpm2-tss

RUN mv -f /etc/sysctl.conf /etc/sysctl.conf.original && \
    mv -f /etc/ipsec.conf /etc/ipsec.conf.original && \
    mv -f /etc/ipsec.secrets /etc/ipsec.secrets.original

COPY rootfs/ /

RUN chmod 755 /usr/local/bin/docker-entrypoint && \
    chmod 755 /usr/local/sbin/set-iptables && \
    chmod 644 /etc/sysctl.conf && \
    chmod 644 /etc/ipsec.conf

HEALTHCHECK --interval=1m --timeout=5s --start-period=40s --retries=3 \
    CMD nc -zu localhost 500 > /dev/null || exit 1

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["docker-entrypoint"]
