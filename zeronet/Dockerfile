FROM python:3.8-alpine

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

RUN export user=zeronet \
  && addgroup -S $user && adduser -D -S -G $user $user

RUN apk add --no-cache --no-progress bash su-exec tor

COPY [ "files/pip.conf", "/etc/" ]
COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/run.sh", "/usr/local/bin/" ]

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN apk add --no-cache --no-progress grep tar \
  && mkdir /app \
  && wget -O- -- https://github.com/HelloZeroNet/ZeroNet/tarball/py3 | tar xz -f - -C /app --strip-components=1 \
  && pip3 install --no-cache-dir --progress-bar off --pre gevent \
  && grep -P '^((?!gevent).)*$' /app/requirements.txt | xargs -n 1 pip3 install --no-cache-dir --progress-bar off \
  && apk del grep tar \
\
  && mv /app/plugins/disabled-UiPassword /app/plugins/UiPassword \
  && echo "ControlPort 9051" >>/etc/tor/torrc \
  && echo "CookieAuthentication 1" >>/etc/tor/torrc

EXPOSE 43110 26552
VOLUME /app/data
WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "run.sh" ]
