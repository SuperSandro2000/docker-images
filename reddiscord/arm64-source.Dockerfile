FROM balenalib/aarch64-debian:sid

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/reddiscord" \
  org.opencontainers.image.documentation="https://red-discordbot.readthedocs.io/en/stable/index.html" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="GPL-3.0" \
  org.opencontainers.image.title="Red-Discord Bot" \
  org.opencontainers.image.description="A multifunction Discord bot"

WORKDIR /app

RUN [ "cross-build-start" ]

RUN groupadd -r reddiscord && useradd -g reddiscord -r reddiscord

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy default-jre-headless git libffi-dev libssl-dev \
    python3-dev python3-levenshtein python3-multidict python3-pip python3-setuptools python3-yarl unzip wget zip \
  && rm -rf /var/lib/apt/lists/*

COPY [ "files/pip.conf", "/etc/" ]
COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/config.json", "/root/.config/Red-DiscordBot/" ]
COPY [ "files/run.sh", "files/Lavalink.jar", "/files/" ]

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy build-essential \
  && pip3 install --no-cache-dir --progress-bar off https://github.com/Cog-Creators/Red-DiscordBot/archive/V3/develop.tar.gz#egg=Red-DiscordBot \
  && apt-get autoremove -qy --purge build-essential unzip zip \
  && rm -rf /var/lib/apt/lists/* \
  && chmod +x /files/run.sh

RUN [ "cross-build-end" ]

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "/files/run.sh" ]
