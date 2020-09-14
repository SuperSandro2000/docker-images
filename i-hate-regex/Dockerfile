FROM debian:testing-slim as git

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG SHA
RUN git clone --depth=1 -- https://github.com/geongeorge/i-hate-regex.git /src

#--------------#

FROM node:14.10.1-slim

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/i-hate-regex" \
  org.opencontainers.image.documentation="https://github.com/geongeorge/i-hate-regex" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="" \
  org.opencontainers.image.title="iHateRegex" \
  org.opencontainers.image.description="The code for iHateregex.io smiling_imp - The Regex Cheat Sheet"

RUN export user=regex \
  && groupadd -r $user && useradd -r -g $user $user

COPY --from=git [ "/src/package.json", "/app/" ]
WORKDIR /app/
RUN yarn install --frozen-lockfile \
  && yarn cache clean

COPY --from=git [ "/src/", "/app/" ]
RUN yarn build

CMD [ "yarn", "run", "nuxt", "start", "-H", "0.0.0.0" ]
