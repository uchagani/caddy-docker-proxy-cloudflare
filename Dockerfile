ARG CADDY_VERSION=2.9.1
FROM caddy:${CADDY_VERSION}-builder AS builder

LABEL org.opencontainers.image.source https://github.com/uchagani/caddy-docker-proxy-cloudflare

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]