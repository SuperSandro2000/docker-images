FROM balenalib/armv7hf-alpine-node:3.10

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

RUN [ "cross-build-start" ]

RUN export user=thelounge \
  && addgroup -S $user && adduser -D -S $user -G $user

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]

RUN apk add --no-cache --no-progress su-exec

RUN yarn global add thelounge

RUN [ "cross-build-end" ]

ENV THELOUNGE_HOME=/app
EXPOSE 3000
WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD ["thelounge", "start"]
