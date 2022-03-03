ARG BUILD_DATE
ARG VERSION=3.4.6
ARG REVISION

FROM tootsuite/mastodon:v$VERSION as mastodon

#--------------#

FROM nginx:alpine

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/mastodon-nginx" \
  org.opencontainers.image.documentation="https://github.com/tootsuite/mastodon" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="AGPL-3.0" \
  org.opencontainers.image.title="Mastodon Nginx" \
  org.opencontainers.image.description="ZeroNet - Decentralized websites using Bitcoin crypto and BitTorrent network"

COPY --from=mastodon [ "/mastodon/public", "/mastodon/public" ]
COPY [ "files/default.template", "/etc/nginx/conf.d/default.template" ]

WORKDIR /etc/nginx/
CMD [ "ash", "-c", "envsubst '${MASTODON_SERVER},${MASTODON_STREAMING},${NGINX_DOMAIN}' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && exec nginx-debug -g 'daemon off;'" ]
