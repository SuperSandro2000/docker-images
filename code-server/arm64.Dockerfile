FROM balenalib/generic-aarch64-alpine-node:8.15.0 as build

ARG GITHUB_TOKEN

WORKDIR /src

COPY code-server-git/ .

RUN [ "cross-build-start" ]

# hadolint ignore=SC2034,SC2039
RUN apk --no-cache --no-progress add g++ git libsecret-dev libxkbfile-dev make python2 \
  && npm install -g yarn@1.13 \
  && for i in {1..3}; do yarn; done \
  && yarn task build:server:binary arm64

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

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /root/project

COPY --from=build /src/packages/server/cli-linux-x64 /usr/local/bin/code-server

RUN [ "cross-build-start" ]

RUN apk --no-cache --no-progress add git net-tools openssl \
  && locale-gen en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*

RUN [ "cross-build-end" ]

EXPOSE 8443

CMD ["code-server"]
