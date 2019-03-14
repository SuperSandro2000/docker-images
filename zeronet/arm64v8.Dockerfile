FROM balenalib/aarch64-alpine:3.9

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

RUN [ "cross-build-start" ]

COPY ["zeronet-git/", "run.sh", "/root/"]

WORKDIR /root

VOLUME /root/data

RUN mv plugins/disabled-UiPassword plugins/UiPassword \
 && apk --no-cache --no-progress add python3 py3-gevent py3-msgpack tor \
 && echo "ControlPort 9051" >> /etc/tor/torrc \
 && echo "CookieAuthentication 1" >> /etc/tor/torrc

RUN [ "cross-build-end" ]

ENV HOME=/root ENABLE_TOR=false

EXPOSE 43110 26552

CMD [ "/root/run.sh" ]
