FROM debian:testing-slim as git

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG SHA
RUN git clone --depth=1 --branch=patch-1 -- https://github.com/SuperSandro2000/c3d2-bullshit-bingo.git /src

#---------------#

FROM nginx:mainline

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/c3d2-bullshit-bingo" \
  org.opencontainers.image.documentation="https://github.com/c3d2/c3d2-bullshit-bingo" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="" \
  org.opencontainers.image.title="c3d2-bullshit-bingo" \
  org.opencontainers.image.description="bullshit bingo"

COPY --from=git [ "/src/", "/usr/share/nginx/html/" ]
COPY [ "files/default.conf", "/etc/nginx/conf.d/default.conf" ]
