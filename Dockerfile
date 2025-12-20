ARG BASE_IMAGE="alpine:latest"
FROM $BASE_IMAGE AS runtime

RUN apk add --no-cache \
    strongswan \
    nftables

COPY rootfs/ /

RUN chmod 755 /usr/local/bin/docker-entrypoint && \
    chmod 755 /usr/local/sbin/setup-firewall && \
    chmod 644 /etc/swanctl/swanctl.conf && \
    chmod 644 /etc/sysctl.conf

HEALTHCHECK --interval=60s --timeout=5s --start-period=30s --retries=3 \
    CMD nc -zu localhost 500 > /dev/null || exit 1

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["docker-entrypoint"]
