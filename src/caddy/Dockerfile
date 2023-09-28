FROM --platform=${BUILDPLATFORM} alpine:latest AS ready
# FROM --platform=${BUILDPLATFORM} alpine:edge AS ready

ARG TARGETPLATFORM

WORKDIR /root

ADD --chmod=777 caddy.sh /root/caddy.sh

# See https://github.com/caddyserver/caddy-docker for details
RUN set -ex \
	&& mkdir -p /config/caddy /data/caddy /etc/caddy /usr/share/caddy \
	&& install -d /config/caddy /data/caddy /etc/caddy /usr/share/caddy \
	&& wget -O /etc/caddy/Caddyfile "https://raw.githubusercontent.com/caddyserver/dist/master/config/Caddyfile" \
	&& wget -O /usr/share/caddy/index.html "https://raw.githubusercontent.com/caddyserver/dist/master/welcome/index.html" \
	&& apk add --no-cache ca-certificates libcap mailcap \
	&& /root/caddy.sh "${TARGETPLATFORM}" \
	&& rm -rfv /root/caddy.sh \
	&& rm -rfv /var/cache/apk/*

FROM --platform=${TARGETPLATFORM} alpine:latest AS final
# FROM --platform=${TARGETPLATFORM} alpine:edge AS final

COPY --from=ready /etc/caddy/Caddyfile /etc/caddy/Caddyfile
COPY --from=ready /usr/share/caddy/index.html /usr/share/caddy/index.html
COPY --from=ready --chmod=755 /usr/bin/caddy /usr/bin/caddy

RUN set -eux; \
	mkdir -p /config/caddy /data/caddy /etc/caddy /usr/share/caddy; \
	install -d /config/caddy /data/caddy /etc/caddy /usr/share/caddy; \
	apk -U upgrade; \
	apk add --no-cache bash ca-certificates tzdata libcap mailcap; \
	rm -rfv /var/cache/apk/*

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data

EXPOSE 80
EXPOSE 443
EXPOSE 443/udp
EXPOSE 2019

WORKDIR /srv

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
