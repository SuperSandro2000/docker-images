FROM alpine:3.10

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="Unbound" \
  org.label-schema.description="Unbound is a validating, recursive, caching DNS resolver." \
  org.label-schema.url="https://nlnetlabs.nl/projects/unbound/about/" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
  org.label-schema.vendor="SuperSandro2000" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

RUN addgroup -S unbound && adduser -S -G unbound unbound

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/unbound.conf", "/etc/unbound/unbound.conf" ]

RUN apk add --no-cache --no-progress bash openssl su-exec unbound \
  && wget https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints

WORKDIR /etc/unbound/
EXPOSE 53/udp
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "unbound" ]
