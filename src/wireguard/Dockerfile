FROM --platform=${TARGETPLATFORM} alpine:latest AS final
# FROM --platform=${TARGETPLATFORM} alpine:edge AS final

ARG TARGETPLATFORM

ADD --chmod=777 wireguard.sh /usr/local/bin/docker-entrypoint.sh

RUN set -ex \
	&& apk -U upgrade \
	&& apk add --no-cache bash ca-certificates grep tzdata dumb-init tini catatonit wireguard-tools iproute2 openresolv nftables iptables ip6tables \
	&& rm -rfv /var/cache/apk/*

VOLUME ["/etc/wireguard"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "docker-entrypoint.sh"]
# ENTRYPOINT ["/usr/bin/dumb-init", "--", "docker-entrypoint.sh"]
# ENTRYPOINT ["/sbin/tini", "--", "docker-entrypoint.sh"]
