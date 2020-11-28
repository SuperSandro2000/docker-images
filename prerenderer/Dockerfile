FROM alpine:3.12 as git

RUN apk add --no-cache \
    git

ARG SHA
RUN git clone https://github.com/prerender/prerender.git /app

#------------------#

FROM node:alpine

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/prerender" \
  org.opencontainers.image.documentation="https://github.com/prerender/prerender" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.title="Prerenderer" \
  org.opencontainers.image.description="Node server that uses Headless Chrome to render a javascript-rendered page as HTML. To be used in conjunction with prerender middleware."

RUN export user=prerenderer \
  && addgroup -S $user && adduser -D -S $user -G $user

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]

RUN apk add --no-cache --no-progress \
    chromium \
    su-exec

COPY --from=git [ "/app", "/app" ]
WORKDIR /app
RUN npm install

COPY [ "files/server.js", "/app/" ]

EXPOSE 3000
WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD ["npm", "start", "server"]
