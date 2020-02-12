FROM node:12-slim as builder

RUN apt-get update \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    g++ \
    git \
    libsecret-1-dev \
    libxkbfile-dev \
    make \
    python \
  && rm -rf /var/lib/apt/lists/*

ARG VERSION=2.1698
RUN git clone --depth=1 --branch=$VERSION -- https://github.com/cdr/code-server.git /src

WORKDIR /src
RUN yarn \
  && yarn cache clean \
  && MINIFY=true BINARY=true ./scripts/ci.bash \
	&& rm -r /src/build \
	&& rm -r /src/source

#--------------#

FROM debian:testing-slim

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/code-server" \
  org.opencontainers.image.documentation="https://github.com/cdr/code-server" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.title="code-server" \
  org.opencontainers.image.description="Run VS Code on a remote server."

RUN export user=coder \
  && groupadd -g 1000 -r $user && useradd -m -r -g 1000 -u 1000 $user

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    dumb-init \
    git \
  && rm -rf /var/lib/apt/lists/*

USER coder

RUN mkdir -p /home/coder/project \
  && mkdir -p /home/coder/.local/share/code-server

COPY --from=builder /src/binaries/code-server /usr/local/bin/code-server

EXPOSE 8080
WORKDIR /home/coder/project
ENTRYPOINT [ "dumb-init", "code-server", "--host", "0.0.0.0" ]
