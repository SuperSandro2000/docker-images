FROM supersandro2000/base-alpine:3.12

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/kibitzr" \
  org.opencontainers.image.documentation="https://kibitzr.github.io/" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.title="Kibitzr" \
  org.opencontainers.image.description="Personal Web Assistant"

RUN export user=kibitzr \
  && addgroup -S $user && adduser -D -S $user -G $user

COPY [ "files/pip.conf", "/etc/" ]
COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/kibitzr-creds.yml", "files/kibitzr.yml", "/usr/src/app/" ]

RUN apk add --no-cache --no-progress \
    ca-certificates \
    git \
    jq \
    python3

ARG VERSION=6.0.0
RUN pip3 install --no-cache-dir --progress-bar off kibitzr==$VERSION

WORKDIR /usr/src/app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "kibitzr", "run" ]
