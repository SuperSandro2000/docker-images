FROM python:3-slim as builder

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy ca-certificates gcc git libcap-dev libjansson-dev \
    libjemalloc-dev libpcre3-dev libxml2-dev libyaml-dev python3-dev python3-distutils zlib1g-dev

RUN git clone --depth=1 https://github.com/unbit/uwsgi.git /uwsgi \
  && printf "\
[uwsgi]\n\
inherit=base\n\
main_plugin=python\n\
malloc_implementation=jemalloc\n\
yaml=libyaml\n\
" >/uwsgi/buildconf/default.ini

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# RUN sh -c 'cd /uwsgi && python3 uwsgiconfig.py --build'
RUN cd /uwsgi && python3 uwsgiconfig.py --build

ARG SHA

RUN git clone --depth=1 https://github.com/healthchecks/healthchecks.git /hc

#------------------#

FROM python:3-slim

ARG BUILD_DATE
ARG VERSION
ARG REVISION

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
COPY --from=builder [ "/hc/requirements.txt", "/app/" ]

# hadolint ignore=SC2086
RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy git gosu libcap2 libjansson4 libjemalloc2 libpq5 libxml2 libyaml-0-2 mime-support \
  && sed -Ei 's/psycopg2==([0-9]+\.){2}[0-9]+/psycopg2-binary==2.8.4/g' /app/requirements.txt \
  && pip3 install --no-cache-dir --progress-bar off -r /app/requirements.txt --no-binary psycopg2 \
  && apt-get autoremove --purge -qy git \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder [ "/uwsgi/uwsgi", "/usr/bin/" ]
COPY [ "files/uwsgi.ini", "/app/" ]
COPY --from=builder [ "/hc/", "/app/" ]

RUN cp /app/hc/local_settings.py.example /app/hc/local_settings.py \
  && sed -i 's/python/python3/g' /app/manage.py \
  && /app/manage.py compress --force \
  && /app/manage.py collectstatic --link --no-color --no-input

EXPOSE 3000
WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "uwsgi", "/app/uwsgi.ini" ]
