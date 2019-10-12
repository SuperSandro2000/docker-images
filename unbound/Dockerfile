FROM supersandro2000/base-alpine:latest

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/unbound" \
  org.opencontainers.image.documentation="https://nlnetlabs.nl/projects/unbound/about/" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="BSD 3-Clause" \
  org.opencontainers.image.title="Unbound" \
  org.opencontainers.image.description="Unbound is a validating, recursive, caching DNS resolver."

RUN export user=unbound \
  && addgroup -S $user && adduser -S $user -G $user

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/unbound.conf", "/etc/unbound/unbound.conf" ]

RUN apk add --no-cache --no-progress openssl unbound \
  && wget https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints

EXPOSE 53/udp
WORKDIR /etc/unbound/
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "unbound", "-d" ]
