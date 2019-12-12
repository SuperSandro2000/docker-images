FROM node:12-alpine

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/thelounge" \
  org.opencontainers.image.documentation="https://github.com/thelounge/thelounge" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.title="TheLounge" \
  org.opencontainers.image.description="Modern, responsive, cross-platform, self-hosted web IRC client"

RUN export user=thelounge \
  && addgroup -S $user && adduser -D -S $user -G $user

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]

RUN apk add --no-cache --no-progress su-exec \
  && if [ "$(uname -m)" = "x86_64" ]; then \
    apk add --no-cache --no-progress g++ make python \
    && npm install -g --unsafe-perm sqlite3 \
    && apk del g++ make python ; \
  fi

RUN yarn global add thelounge

ENV THELOUNGE_HOME=/app
EXPOSE 9000
WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD ["thelounge", "start"]