FROM supersandro2000/base-alpine:3.11

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/iodine" \
  org.opencontainers.image.documentation="https://code.kryo.se/iodine/" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="ISC" \
  org.opencontainers.image.title="Iodine" \
  org.opencontainers.image.description="iodine lets you tunnel IPv4 data through a DNS server."

RUN export user=iodine \
  && addgroup -S $user && adduser -D -S $user -G $user

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]

RUN apk add --no-cache --no-progress --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ iodine

EXPOSE 53/udp
WORKDIR /data
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "iodined" ]
