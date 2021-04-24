FROM debian:testing as git

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG NGINX_VERSION=1.19.10
RUN git clone --depth=1 --recurse-submodules --shallow-submodules https://github.com/weserv/images.git /src

#--------------#

FROM debian:bullseye

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/images-weserv" \
  org.opencontainers.image.documentation="https://images.weserv.nl/" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="BSD-3" \
  org.opencontainers.image.title="Images Weserv" \
  org.opencontainers.image.description="Source code of images.weserv.nl, to be used on your own server(s)."

RUN groupadd nginx \
  && useradd -r -g nginx -s /sbin/nologin -c "Nginx web server" nginx

COPY --from=git [ "/src", "/var/www/imagesweserv" ]

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /var/www/imagesweserv/build
RUN export dev_apt=( \
    "ca-certificates" \
    "cmake" \
    "g++" \
    "git" \
    "libjpeg-dev" \
    "libssl-dev" \
    "libvips-dev" \
    "make" \
    "pkg-config" \
  ) \
  && apt-get update -q \
  && apt-get install --no-install-recommends -qy "${dev_apt[@]}" \
    libvips42 \
  && cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_TOOLS=ON \
  -DNGX_VERSION="$NGINX_VERSION" \
  -DCUSTOM_NGX_FLAGS="--prefix=/usr/share/nginx;\
--sbin-path=/usr/sbin/nginx;\
--modules-path=/usr/lib64/nginx/modules;\
--conf-path=/etc/nginx/nginx.conf;\
--error-log-path=/var/log/nginx/error.log;\
--http-log-path=/var/log/nginx/access.log;\
--http-client-body-temp-path=/var/lib/nginx/tmp/client_body;\
--http-proxy-temp-path=/var/lib/nginx/tmp/proxy;\
--http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi;\
--http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi;\
--http-scgi-temp-path=/var/lib/nginx/tmp/scgi;\
--pid-path=/run/nginx.pid;\
--lock-path=/run/lock/subsys/nginx;\
--user=nginx;\
--group=nginx" \
  && make -j"$(nproc)" \
  && ldconfig \
  && apt-get autoremove --purge -qy "${dev_apt[@]}" \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -m 700 /var/lib/nginx \
    && mkdir -m 700 /var/lib/nginx/tmp \
    && mkdir -m 700 /usr/lib64 \
    && mkdir -m 700 /usr/lib64/nginx \
    && mkdir -m 755 /usr/lib64/nginx/modules \
    # Forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/weserv-access.log \
    && ln -sf /dev/stderr /var/log/nginx/weserv-error.log \
    # Copy nginx configuration to the appropriate location
    && cp /var/www/imagesweserv/ngx_conf/*.conf /etc/nginx

EXPOSE 80
STOPSIGNAL SIGTERM
ENTRYPOINT ["nginx", "-g", "daemon off;"]
