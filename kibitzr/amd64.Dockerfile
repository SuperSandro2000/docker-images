FROM alpine:3.10

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="Kibitzr" \
  org.label-schema.description="Get notified when important things happen" \
  org.label-schema.url="https://kibitzr.github.io/" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
  org.label-schema.vendor="SuperSandro2000" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

RUN addgroup -S kibitzr && adduser -S -G kibitzr kibitzr

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/kibitzr-creds.yml", "files/kibitzr.yml", "/usr/src/app/" ]

RUN apk add --no-cache --no-progress ca-certificates git jq python3 py3-cffi py3-cryptography py3-lxml py3-pip py3-yaml su-exec \
  && pip3 install --no-cache-dir --progress-bar off kibitzr

WORKDIR /usr/src/app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "kibitzr", "run" ]
