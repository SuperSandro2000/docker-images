FROM node:14-slim as builder

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

ARG VERSION=3.0.0
RUN git clone --branch=$VERSION --depth=1 --recurse-submodules --shallow-submodules -- https://github.com/cdr/code-server.git /src

WORKDIR /src/
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN yarn install --frozen-lockfile \
  && yarn vscode:patch &>/dev/null

WORKDIR /src/lib/vscode/
# hadolint ignore=SC2034
RUN for i in {1..3}; do \
    yarn install --frozen-lockfile && break || sleep 15; \
  done \
  && npm rebuild \
  && yarn gulp compile-build \
  && yarn gulp compile-extensions-build

WORKDIR /src/
ENV MINIFY=true \
  NODE_ENV=production
RUN ./ci/release.sh \
  && cp "$(command -v node)" ./build \
  && cp README.md ./build \
  && cp LICENSE.txt ./build \
  && cp ./lib/vscode/ThirdPartyNotices.txt ./build \
  && cp ./ci/code-server.sh ./build/code-server

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

COPY --from=builder /src/build/ /usr/local/lib/code-server

RUN ln -s /usr/local/lib/code-server/code-server /usr/local/bin/code-server

USER coder
RUN mkdir -p /home/coder/project \
  && mkdir -p /home/coder/.local/share/code-server

EXPOSE 8080
WORKDIR /home/coder/project
ENTRYPOINT [ "dumb-init", "code-server", "--host", "0.0.0.0" ]
