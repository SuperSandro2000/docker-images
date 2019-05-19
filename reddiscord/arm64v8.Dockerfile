FROM balenalib/aarch64-debian:buster

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

COPY ["files/config.json", "/root/.config/Red-DiscordBot/"]
COPY ["files/run.sh", "files/Lavalink.jar", "/files/"]

RUN [ "cross-build-start" ]

RUN apt update -qq \
  && apt install --no-install-recommends -qqy build-essential default-jre-headless git libffi-dev libssl-dev python3-aiohttp \
  python3-dev python3-levenshtein python3-pip python3-setuptools python3-yaml unzip zip \
  && pip3 install -U --process-dependency-links --no-cache-dir --progress-bar off Red-DiscordBot[voice] \
  && apt remove -qqy --purge build-essential unzip zip \
  && apt autoremove -qqy --purge \
  && apt clean \
  && rm -rf /var/lib/apt/lists/* \
  && chmod +x /files/run.sh

RUN [ "cross-build-end" ]

CMD [ "/files/run.sh" ]
