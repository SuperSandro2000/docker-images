FROM node:buster-slim

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="Prerenderer" \
  org.label-schema.description="Node server that uses Headless Chrome to render a javascript-rendered page as HTML." \
  org.label-schema.url="https://github.com/prerender/prerender" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
  org.label-schema.vendor="SuperSandro2000" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

RUN groupadd -r prerenderer && useradd -g prerenderer -r prerenderer

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy chromium git gosu \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/prerender/prerender.git . \
  && npm install

COPY [ "files/server.js", "/app/" ]

ENTRYPOINT [ "entrypoint.sh" ]
CMD ["npm", "start", "server"]
