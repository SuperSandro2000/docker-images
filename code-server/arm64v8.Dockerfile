FROM balenalib/generic-aarch64-alpine-node:8.15.0

WORKDIR /src

COPY code-server-git/ .

RUN [ "cross-build-start" ]

RUN apk --no-cache --no-progress add g++ git libsecret-dev libxkbfile-dev make \
  && npm install -g yarn@1.13 \
  && for i in {1..3}; do yarn; done \
  && yarn task build:server:binary

RUN [ "cross-build-end" ]

#-------------------#

FROM balenalib/aarch64-alpine:3.9

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="Code-Server" \
  org.label-schema.description="Run VS Code on a remote server." \
  org.label-schema.url="https://coder.com/" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
  org.label-schema.vendor="SuperSandro2000" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

WORKDIR /root/project

COPY --from=0 /src/packages/server/cli-linux-x64 /usr/local/bin/code-server

RUN [ "cross-build-start" ]

RUN apk --no-cache --no-progress add git net-tools openssl \
  && locale-gen en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*

RUN [ "cross-build-end" ]

ENV LANG=en_US.UTF-8

EXPOSE 8443

ENTRYPOINT ["code-server"]
