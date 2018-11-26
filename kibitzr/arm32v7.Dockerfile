FROM resin/armv7hf-alpine:3.8

MAINTAINER Sandro Jäckel <sandro.jaeckel@gmail.com>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kibitzr" \
      org.label-schema.description="Get notified when important things happen" \
      org.label-schema.url="https://kibitzr.github.io/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
      org.label-schema.vendor="SuperSandro2000" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

RUN [ "cross-build-start" ]

WORKDIR /usr/src/app

RUN apk add --no-cache -q ca-certificates git jq python2 py-cffi py-cryptography py-lxml py-pip py-yaml \
&& pip install --no-cache-dir -q kibitzr \
&& rm -rf /var/cache/apk/*

COPY ["kibitzr-creds.yml", "kibitzr.yml", "./"]

RUN [ "cross-build-end" ]

CMD [ "kibitzr", "run" ]
