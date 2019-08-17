FROM balenalib/aarch64-alpine:3.10

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="ZeroNet" \
  org.label-schema.description="Open, free and uncensorable websites, using Bitcoin cryptography and BitTorrent network." \
  org.label-schema.url="https://zeronet.io" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
  org.label-schema.vendor="SuperSandro2000" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

ENV HOME=/app ENABLE_TOR=false

RUN [ "cross-build-start" ]

RUN addgroup -S zeronet && adduser -S -G zeronet zeronet

RUN  apk add --no-cache --no-progress openssl python3 py3-msgpack py3-pysocks su-exec tor \
  # only fetch specific packages from testing
  && apk add --no-cache --no-progress -X http://dl-cdn.alpinelinux.org/alpine/edge/testing py3-gevent-websocket

RUN apk add --no-cache --no-progress --virtual .build-deps g++ libffi-dev make python3-dev \
  && pip3 install --no-cache-dir --progress-bar off base58 bencode.py coincurve merkletools python-bitcoinlib \
  && apk del .build-deps

COPY [ "files/pip.conf", "/etc/" ]
COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/run.sh", "/usr/local/bin/" ]
COPY [ "zeronet-git/", "/app/" ]

RUN mv /app/plugins/disabled-UiPassword /app/plugins/UiPassword

RUN [ "cross-build-end" ]

VOLUME /app/data
EXPOSE 43110 26552
WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "run.sh" ]
