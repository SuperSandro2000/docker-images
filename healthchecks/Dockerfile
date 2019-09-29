FROM debian:sid-slim as builder

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy ca-certificates gcc git libcap-dev libjansson-dev \
    libjemalloc-dev libpcre3-dev libxml2-dev libyaml-dev python3-dev python3-distutils zlib1g-dev

WORKDIR /uwsgi

RUN git clone --depth=1 https://github.com/unbit/uwsgi.git . \
  && printf "\
[uwsgi]\n\
inherit=base\n\
main_plugin=python\n\
malloc_implementation=jemalloc\n\
yaml=libyaml\n\
" >/uwsgi/buildconf/default.ini \
  && python3 uwsgiconfig.py --build

#------------------#

FROM debian:sid-slim

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="Healthchecks" \
  org.label-schema.description="Unbound is a validating, recursive, caching DNS resolver." \
  org.label-schema.url="https://github.com/healthchecks/healthchecks/" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
  org.label-schema.vendor="SuperSandro2000" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

RUN groupadd -r healthchecks && useradd -g healthchecks -r healthchecks

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "healthchecks-git/requirements.txt", "." ]

# hadolint ignore=SC2086
RUN export dev_apt="gcc libpq-dev python3-dev python3-pip python3-setuptools" \
  && apt-get update -q \
  && apt-get install --no-install-recommends -qy gosu python3 \
    libcap2 libjansson4 libjemalloc2 libpython3.7 libxml2 libyaml-0-2 \
    $dev_apt \
  && pip3 install --no-cache-dir --progress-bar off -r requirements.txt --no-binary psycopg2 \
  && apt-get autoremove -qy --purge $dev_apt \
  && unset dev_apt \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder [ "/uwsgi/uwsgi", "/usr/bin/" ]
COPY [ "files/uwsgi.ini", "/app/" ]
COPY [ "healthchecks-git/", "/app/" ]

RUN cp /app/hc/local_settings.py.example /app/hc/local_settings.py \
  && sed -i 's/python/python3/g' /app/manage.py \
  && /app/manage.py compress --force \
  && /app/manage.py collectstatic --link --no-color --no-input

WORKDIR /app
EXPOSE 3000
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "uwsgi", "/app/uwsgi.ini" ]
