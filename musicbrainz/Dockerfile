FROM node:buster-slim as node

ENV NODE_ENV=production

RUN apt-get update \
  && apt-get install --no-install-recommends -qy ca-certificates git libaliased-perl libjson-perl libmoose-perl libreadonly-perl libstring-random-perl libstring-shellquote-perl

ARG VERSION=v-2019-12-10-hotfix

RUN git clone --depth=100 https://github.com/metabrainz/musicbrainz-server.git /musicbrainz

WORKDIR /musicbrainz

COPY [ "files/DBDefs.pm", "/musicbrainz/lib/DBDefs.pm" ]

RUN git checkout $VERSION \
  && script/compile_resources.sh \ 
  && rm -r /musicbrainz/node_modules

#------------------#

FROM debian:buster-slim

ARG BUILD_DATE
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/metabrainz" \
  org.opencontainers.image.documentation="https://musicbrainz.org/doc/About" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="GPL-2.0,BSD-2" \
  org.opencontainers.image.title="MusicBrainz Server" \
  org.opencontainers.image.description="The official musicbrainz-server codebase"

ENV NODE_ENV=production

RUN export user=musicbrainz \
  && groupadd -r $user && useradd -mr -g $user $user

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]

# hadolint ignore=SC2086
RUN export dev_apt="cpanminus gcc libicu-dev make pkg-config" \
  && apt-get update \
  # runtime and tools
  && apt-get install --no-install-recommends -qy $dev_apt gosu perl \
  # perl modules
  libauthen-passphrase-perl libcatalyst-authentication-credential-http-perl libcatalyst-plugin-cache-perl libcatalyst-plugin-session-state-cookie-perl libclone-perl libdata-compare-perl libdatetime-format-pg-perl libfile-slurp-perl libintl-perl libjson-perl libjson-xs-perl liblist-allutils-perl liblog-dispatch-perl liblist-moreutils-perl libmath-random-mt-perl libmath-random-secure-perl libmoosex-role-parameterized-perl libmoosex-singleton-perl libobject-insideout-perl libplack-middleware-debug-perl libreadonly-perl libredis-perl libstatistics-basic-perl libtemplate-perl libtest-www-mechanize-catalyst-perl libtext-trim-perl libtext-unaccent-perl libtext-wikiformat-perl \
  && cpanm --installdeps --notest Catalyst::Plugin::Cache::HTTP Data::UUID::MT Unicode::ICU::Collator \
  && apt-get autoremove --purge -qy $dev_apt \
  && rm -rf /var/lib/apt/lists/*

COPY --from=node [ "/musicbrainz/", "/app/" ]

WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "plackup", "-Ilib", "-r" ]
