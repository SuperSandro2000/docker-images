FROM alpine:3.8

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="ZeroNet" \
  org.label-schema.description="Get notified when important things happen" \
  org.label-schema.url="https://zeronet.io" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
  org.label-schema.vendor="SuperSandro2000" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

COPY zeronet-git/ /root

WORKDIR /root

VOLUME /root/data

RUN mv plugins/disabled-UiPassword plugins/UiPassword \
 && apk --no-cache --no-progress add python py2-gevent py2-msgpack tor \
 && echo "ControlPort 9051" >> /etc/tor/torrc \
 && echo "CookieAuthentication 1" >> /etc/tor/torrc

ENV HOME=/root ENABLE_TOR=false

EXPOSE 43110 26552

CMD ["(!", "${ENABLE_TOR}", "||","tor&)", "&&", "python", "zeronet.py", "--ui_ip", "0.0.0.0", "--fileserver_port", "26552", "--ui_password", "${UI_PASSWORD}"]
