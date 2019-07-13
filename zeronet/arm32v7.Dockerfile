FROM balenalib/armv7hf-alpine:3.10

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

ENV HOME=/root ENABLE_TOR=false

WORKDIR /root

RUN [ "cross-build-start" ]

RUN apk --no-cache --no-progress add python2 py2-gevent py2-msgpack tor \
  && echo "ControlPort 9051" >>/etc/tor/torrc \
  && echo "CookieAuthentication 1" >>/etc/tor/torrc

COPY ["zeronet-git/", "files/run.sh", "/root/"]

RUN mv /root/plugins/disabled-UiPassword /root/plugins/UiPassword

RUN [ "cross-build-end" ]

VOLUME /root/data

EXPOSE 43110 26552

CMD [ "/root/run.sh" ]
