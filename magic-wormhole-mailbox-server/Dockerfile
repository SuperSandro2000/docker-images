FROM debian:testing-slim

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/magic-wormhole-mailbox-server" \
  org.opencontainers.image.documentation="https://github.com/warner/magic-wormhole-mailbox-server/tree/master/docs" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.title="magic-wormhole-mailbox-server" \
  org.opencontainers.image.description="the rendezvous/mailbox server for magic-wormhole clients"

RUN export user=wormhole \
  && groupadd -r $user && useradd -r -g $user $user

RUN apt-get update \
  && apt-get install --no-install-recommends -qy \
    python3-pip \
    python3-twisted \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir --progress-bar off magic-wormhole-mailbox-server==0.4.1

EXPOSE 4000
CMD [ "twist3", "wormhole-mailbox", "--port=tcp:4000", "--blur-usage=100" ]
