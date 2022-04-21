FROM debian:testing-slim as git

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG VERSION=2.0.1
RUN git clone --depth=1 --branch="v$VERSION" -- https://github.com/healthchecks/healthchecks.git /hc \
  && rm -r /hc/.git

#------------------#

FROM python:3.10.4 as py

FROM py as builder

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy \
    ca-certificates \
    gcc \
    git \
    libcap-dev \
    libjansson-dev \
    libjemalloc-dev \
    libpcre3-dev \
    libxml2-dev \
    libyaml-dev \
    zlib1g-dev

ARG UWSGI_VERSION=2.0.20
RUN git clone --depth=1 --branch="$UWSGI_VERSION" https://github.com/unbit/uwsgi.git /uwsgi \
  && rm -r /uwsgi/.git \
  && printf "\
[uwsgi]\n\
inherit=base\n\
main_plugin=python\n\
malloc_implementation=jemalloc\n\
yaml=libyaml\n\
" >/uwsgi/buildconf/default.ini

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /uwsgi
RUN python3 uwsgiconfig.py --build -v

#------------------#

FROM py

ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/healthchecks" \
  org.opencontainers.image.documentation="https://github.com/healthchecks/healthchecks/" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="BSD 3-Clause" \
  org.opencontainers.image.title="Healthchecks" \
  org.opencontainers.image.description="A Cron Monitoring Tool written in Python & Django"

RUN export user=healthchecks \
  && groupadd -r $user && useradd -r -g $user $user

COPY [ "files/pip.conf", "/etc/" ]
COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY --from=git [ "/hc/requirements.txt", "/app/" ]

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy \
    gosu \
    libcap2 \
    libjansson4 \
    libjemalloc2 \
    libpq5 \
    libxml2 \
    libyaml-0-2 \
    mime-support \
  && pip3 install --no-cache-dir --progress-bar off -r /app/requirements.txt \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder [ "/uwsgi/uwsgi", "/usr/bin/" ]
COPY [ "files/uwsgi.ini", "/app/" ]
COPY --from=git [ "/hc/", "/app/" ]

ENV PYTHONUNBUFFERED=1
ENV DEBUG=False
RUN echo "static-safe = $(realpath /usr/local/lib/python3.*/site-packages/django/contrib/admin/static/admin)/" >> /app/uwsgi.ini \
  && cp /app/hc/local_settings.py.example /app/hc/local_settings.py \
  && sed -i 's/python/python3/g' /app/manage.py \
  && /app/manage.py collectstatic --no-color --no-input \
  && /app/manage.py compress --force

EXPOSE 3000
WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "uwsgi", "/app/uwsgi.ini" ]
