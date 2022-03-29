FROM debian:testing-slim

ARG VERSION

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
    wget \
  && rm -rf /var/lib/apt/lists/*

ARG VERSION=4.2.0
RUN wget -q https://github.com/cdr/code-server/releases/download/v${VERSION}/code-server_${VERSION}_amd64.deb -O /code-server_${VERSION}_amd64.deb \
  && apt-get install -qy --no-install-recommends /code-server_${VERSION}_amd64.deb \
  && rm /code-server_${VERSION}_amd64.deb

USER coder
RUN mkdir -p /home/coder/project \
  && mkdir -p /home/coder/.local/share/code-server

EXPOSE 8080
ENV NODE_ENV=production
WORKDIR /home/coder/project
ENTRYPOINT [ "dumb-init", "code-server", "--host", "0.0.0.0" ]
