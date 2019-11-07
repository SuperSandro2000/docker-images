FROM supersandro2000/base-alpine:armhf-3.10

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/zeronet" \
  org.opencontainers.image.documentation="https://zeronet.io/docs/" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="GPL-2.0" \
  org.opencontainers.image.title="ZeroNet" \
  org.opencontainers.image.description="ZeroNet - Decentralized websites using Bitcoin crypto and BitTorrent network"

ENV HOME=/app ENABLE_TOR=false

RUN [ "cross-build-start" ]

RUN export user=zeronet \
  && addgroup -S $user && adduser -D -S -G $user $user

RUN apk add --no-cache --no-progress openssl python3 py3-msgpack py3-pysocks py3-rsa py3-websocket-client tor \
  # only fetch specific packages from testing
  && apk add --no-cache --no-progress --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing py3-maxminddb py3-gevent-websocket

COPY [ "files/pip.conf", "/etc/" ]
COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/run.sh", "/usr/local/bin/" ]

RUN apk add --no-cache --no-progress git \
  && git clone --depth=1 https://github.com/HelloZeroNet/ZeroNet.git /app \
  && apk del git

RUN apk add --no-cache --no-progress --virtual .build-deps g++ libffi-dev make python3-dev \
  && pip3 install --no-cache-dir --progress-bar off -r /app/requirements.txt \
  && mv /app/plugins/disabled-UiPassword /app/plugins/UiPassword \
  && echo "ControlPort 9051" >>/etc/tor/torrc \
  && echo "CookieAuthentication 1" >>/etc/tor/torrc \
  && apk del .build-deps

RUN [ "cross-build-end" ]

EXPOSE 43110 26552
VOLUME /app/data
WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "run.sh" ]
