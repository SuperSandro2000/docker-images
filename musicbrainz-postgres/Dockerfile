ARG VERSION=12

FROM alpine:3.15.2 as builder

RUN apk add --no-cache \
    ca-certificates \
    gcc \
    git \
    icu-dev \
    make \
    musl-dev \
    postgresql-dev

#------------------#

FROM builder as collate

RUN git clone --depth=1 https://github.com/metabrainz/postgresql-musicbrainz-collate.git /postgresql-musicbrainz-collate \
  && rm -r /postgresql-musicbrainz-collate/.git

WORKDIR /postgresql-musicbrainz-collate
RUN make \
  && strip musicbrainz_collate.so

#------------------#

FROM builder as unaccent

RUN git clone --depth=1 https://github.com/metabrainz/postgresql-musicbrainz-unaccent.git /postgresql-musicbrainz-unaccent \
  && rm -r /postgresql-musicbrainz-unaccent/.git

WORKDIR /postgresql-musicbrainz-unaccent
RUN make \
  && strip musicbrainz_unaccent.so

#------------------#

FROM postgres:${VERSION}-alpine as postgres

ARG BUILD_DATE
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/metabrainz-postgres" \
  org.opencontainers.image.documentation="https://musicbrainz.org/doc/About" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="GPL-2.0" \
  org.opencontainers.image.title="MusicBrainz Postgres Server" \
  org.opencontainers.image.description="PostgreSQL with MusicBrainz collation and MusicBrainz unaccenting routines"

COPY --from=collate [ "/postgresql-musicbrainz-collate/musicbrainz_collate.so", "/usr/local/lib/postgresql/musicbrainz_collate.so" ]
COPY --from=collate [ "/postgresql-musicbrainz-collate/musicbrainz_collate.control", "/postgresql-musicbrainz-collate/sql/musicbrainz_collate.sql", "/postgresql-musicbrainz-collate/sql/musicbrainz_collate--1.0.0.sql", "/usr/local/share/postgresql/extension/" ]
COPY --from=collate [ "/postgresql-musicbrainz-collate/README.musicbrainz_collate.md", "/usr/local/share/doc/postgresql/extension/" ]

COPY --from=unaccent [ "/postgresql-musicbrainz-unaccent/musicbrainz_unaccent.so", "/usr/local/lib/postgresql/musicbrainz_unaccent.so" ]
COPY --from=unaccent [ "/postgresql-musicbrainz-unaccent/musicbrainz_unaccent.control", "/postgresql-musicbrainz-unaccent/sql/musicbrainz_unaccent.sql", "/postgresql-musicbrainz-unaccent/sql/uninstall_musicbrainz_unaccent.sql", "/postgresql-musicbrainz-unaccent/sql/musicbrainz_unaccent--1.0.0.sql", "/usr/local/share/postgresql/extension/" ]
COPY --from=unaccent [ "/postgresql-musicbrainz-unaccent/README.musicbrainz_unaccent.md", "/usr/local/share/doc/postgresql/extension/" ]

RUN chmod 755 /usr/local/lib/postgresql/*.so \
  && chmod 644 /usr/local/share/postgresql/extension/* \
  && chmod 644 /usr/local/share/doc/postgresql/extension/*
