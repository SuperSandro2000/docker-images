FROM balenalib/armv7hf-debian:sid

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="Red-Discord Bot" \
  org.label-schema.description="A multifunction Discord bot" \
  org.label-schema.url="https://github.com/Cog-Creators/Red-DiscordBot/tree/V3/develop" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
  org.label-schema.vendor="SuperSandro2000" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

WORKDIR /app

RUN [ "cross-build-start" ]

RUN apt-get update -qq \
  && apt-get install --no-install-recommends -qqy default-jre-headless git libffi-dev libssl-dev \
    python3-dev python3-levenshtein python3-multidict python3-pip python3-setuptools python3-yarl unzip wget zip \
  && rm -rf /var/lib/apt/lists/*

COPY ["files/config.json", "/root/.config/Red-DiscordBot/"]
COPY ["files/run.sh", "files/Lavalink.jar", "/files/"]
COPY ["files/pip.conf", "/etc/"]

RUN apt-get update -qq \
  && apt-get install --no-install-recommends -qqy build-essential \
  && pip3 install --no-cache-dir --progress-bar off https://github.com/Cog-Creators/Red-DiscordBot/archive/V3/develop.tar.gz#egg=Red-DiscordBot \
  && apt-get remove -qqy --purge build-essential unzip zip \
  && apt-get autoremove -qqy --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && chmod +x /files/run.sh

RUN [ "cross-build-end" ]

CMD [ "/files/run.sh" ]
