FROM debian:testing-slim as git

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG VERSION=3.4.12
RUN git clone --depth=1 --branch=$VERSION -- https://github.com/Cog-Creators/Red-DiscordBot.git /app \
  && rm -r /app/.git

#-------------------#

FROM python:3.8-slim

ARG VERSION

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
  && groupadd -r $user && useradd -r -g $user $user \
  # deal with slim variants not having man page directories (which causes "update-alternatives" to fail)
  # https://github.com/docker-library/openjdk/blob/0584b2804ed12dca7c5e264b5fc55fc07a3ac148/8-jre/slim/Dockerfile#L51-L54
  && mkdir -p /usr/share/man/man1

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy \
    default-jre-headless \
    gosu \
  && rm -rf /var/lib/apt/lists/*

COPY [ "files/pip.conf", "/etc/" ]
COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/config.json", "/usr/local/share/Red-DiscordBot/config.json" ]
COPY --from=git [ "/app/", "/app/" ]

RUN pip3 install --no-cache-dir --progress-bar off /app/ \
  && mkdir /data \
  && chown -R reddiscord:reddiscord /app

WORKDIR /data
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "redbot", "docker" ]
