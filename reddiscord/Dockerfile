FROM debian:buster

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

RUN export user=reddiscord \
  && groupadd -r $user && useradd -r -g $user $user

# hadolint ignore=SC2086
RUN export dev_apt="libffi-dev libssl-dev" \
  && apt-get update -q \
  && apt-get install --no-install-recommends -qy $dev_apt \
    default-jre-headless \
    git \
    gosu \
    libffi6 libssl1.1 \
    python3-dev \
    python3-levenshtein \
    python3-multidict \
    python3-pip \
    python3-setuptools \
    python3-yarl \
    wget \
  && apt-get autoremove --purge -qy $dev_apt \
  && rm -rf /var/lib/apt/lists/*

COPY [ "files/pip.conf", "/etc/" ]
COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/config.json", "/usr/local/share/Red-DiscordBot/" ]
COPY [ "files/run.sh", "files/Lavalink.jar", "/files/" ]

# hadolint ignore=SC2086
RUN export dev_apt="build-essential unzip zip" \
  && apt-get update -q \
  && apt-get install --no-install-recommends -qy $dev_apt \
  && pip3 install --no-cache-dir --progress-bar off Red-DiscordBot \
  && apt-get autoremove --purge -qy $dev_apt \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "/files/run.sh" ]
