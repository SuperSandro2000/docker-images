FROM supersandro2000/base-alpine:3.15

ARG VERSION

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

ARG VERSION=6.1.1
RUN apk add --no-cache --no-progress \
    ca-certificates \
    git \
    jq \
    py3-cffi \
    py3-pip \
  && pip3 install --no-cache-dir --progress-bar off --upgrade pip \
  && pip3 install --no-cache-dir --progress-bar off kibitzr==$VERSION \
  && pip3 uninstall --no-cache-dir -y pip \
  && apk del py3-pip

WORKDIR /usr/src/app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "kibitzr", "run" ]
