FROM node:buster-slim as builder

ENV NODE_ENV=production

RUN apt-get update \
  && apt-get install --no-install-recommends -qy \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG VERSION=v-2020-01-06

RUN git clone --depth=1 --branch $VERSION -- https://github.com/metabrainz/musicbrainz-server.git /app

WORKDIR /app

COPY [ "files/DBDefs.pm", "/app/lib/DBDefs.pm" ]

RUN yarn

#------------------#

FROM node:buster-slim

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

RUN apt-get update \
  && apt-get install --no-install-recommends -qy \
  # runtime
    git \
    gosu \
    perl \
  # import tools
    bzip2 \
    libpq-dev \
    postgresql-client-11 \
  # perl modules
    libaliased-perl \
    libauthen-passphrase-perl \
    libdbd-pg-perl \
    libdbix-connector-perl \
    libcaptcha-recaptcha-perl \
    libcatalyst-action-renderview-perl \
    libcatalyst-authentication-credential-http-perl \
    libcatalyst-plugin-cache-perl \
    libcatalyst-plugin-session-state-cookie-perl \
    libcatalyst-view-tt-perl \
    libcgi-expand-perl \
    libdata-compare-perl \
    libdata-page-perl \
    libdate-calc-perl \
    libdatetime-format-iso8601-perl \
    libdatetime-format-natural-perl \
    libdatetime-format-pg-perl \
    libdigest-md5-file-perl \
    libemail-address-perl \
    libemail-mime-perl \
    libemail-sender-perl \
    libgnupg-perl \
    libhash-merge-perl \
    libhtml-formhandler-perl \
    libhtml-treebuilder-xpath-perl \
    libfile-slurp-perl \
    libintl-perl \
    libio-all-perl \
    libio-string-perl \
    libjson-perl \
    libjson-xs-perl \
    liblist-allutils-perl \
    liblog-dispatch-perl \
    liblist-moreutils-perl \
    libmath-random-mt-perl \
    libmath-random-secure-perl \
    libmethod-signatures-simple-perl \
    libmoosex-clone-perl \
    libmoosex-role-parameterized-perl \
    libmoosex-singleton-perl \
    libmoosex-types-structured-perl \
    libmoosex-types-uri-perl \
    libobject-insideout-perl \
    libplack-middleware-debug-perl \
    libreadonly-perl \
    libredis-perl \
    libset-scalar-perl \
    libstatistics-basic-perl \
    libstring-camelcase-perl \
    libstring-random-perl \
    libstring-shellquote-perl \
    libstring-tt-perl \
    libtemplate-plugin-class-perl \
    libtemplate-plugin-javascript-perl \
    libtest-fatal-perl libtest-base-perl \
    libtest-www-mechanize-catalyst-perl \
    libtext-markdown-perl \
    libtext-trim-perl \
    libtext-unaccent-perl \
    libtext-wikiformat-perl \
    libthrowable-perl \
    libxml-parser-lite-perl \
    libxml-simple-perl \
    libxml-xpath-perl \
  && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN export dev_apt=(\
    "cpanminus" \
    "gcc" \
    "libicu-dev" \
    "make" \
    "pkg-config" \
  ) \
  && apt-get update \
  && apt-get install -qy --no-install-recommends "${dev_apt[@]}" \
    libicu63 \
  && cpanm --notest \
    Catalyst::Plugin::Cache::HTTP \
    Data::UUID::MT MooseX::ABC \
    REST::Utils \
    Net::Amazon::AWSSign \
    Text::Diff3 \
    Unicode::ICU::Collator \
    XML::RSS::Parser::Lite \
  && apt-get autoremove --purge -qy "${dev_apt[@]}" \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder [ "/app", "/app" ]

WORKDIR /app

RUN mkdir -p /app/.nyc_output /app/data \
  && chown musicbrainz:musicbrainz /app/.nyc_output

VOLUME /app/data
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "plackup", "-Ilib", "-r" ]
