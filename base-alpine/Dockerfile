ARG VERSION=3.13
FROM alpine:$VERSION

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/base-alpine" \
  org.opencontainers.image.documentation="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="GPL-3.0" \
  org.opencontainers.image.title="Alpine Base Image" \
  org.opencontainers.image.description="Base Image with very common things and fixes"

RUN apk add --no-cache --no-progress \
    bash \
    su-exec \
    tzdata

CMD [ "bash" ]
