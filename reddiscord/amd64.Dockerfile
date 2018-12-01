FROM debian:buster

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

COPY ["config.json", "/root/.config/Red-DiscordBot/"]

WORKDIR /app

RUN apt-get -q update \
  && apt-get -q install --no-install-recommends -y build-essential default-jre-headless git libffi-dev libssl-dev python3-aiohttp \
  python3-dev python3-levenshtein python3-pip python3-setuptools python3-yaml unzip wget zip \
  && pip3 install -Uq --process-dependency-links --no-cache-dir Red-DiscordBot[voice] \
  && rm ~/.cache/pip -rf \
  && apt-get -q remove -y build-essential \
  && apt-get -q autoremove -y \
  && rm -rf /var/lib/apt/lists/*

CMD [ "redbot", "docker" ]
