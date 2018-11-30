FROM resin/aarch64-debian:buster

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

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN [ "cross-build-start" ]

WORKDIR /app

COPY ["config.json", "/root/.config/Red-DiscordBot/"]
COPY ["libconnector.so", "/files/"]
COPY ["run.sh", "/files/"]

RUN apt-get update \
  && apt-get install --no-install-recommends -y build-essential default-jre-headless git libffi-dev libssl-dev python3-aiohttp \
  python3-dev python3-levenshtein python3-pip python3-setuptools python3-yaml unzip wget zip \
  && pip3 install -U --process-dependency-links --no-cache-dir Red-DiscordBot[voice] \
  && curl -s https://api.github.com/repos/Cog-Creators/Red-DiscordBot/releases \
  | grep "Lavalink.jar" -m2  | tail -n1 | cut -d : -f 2,3 | tr -d \" | wget -qi - \
  && mkdir -p natives/linux-arm/ \
  && mv /files/libconnector.so natives/linux-arm/ \
  && zip Lavalink.jar natives/linux-arm/libconnector.so \
  && mv Lavalink.jar /files/ \
  && rm -r natives/ \
  && rm ~/.cache/pip -rf \
  && apt-get remove -y build-essential unzip wget zip \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* \
  && chmod +x /files/run.sh

RUN [ "cross-build-end" ]

CMD [ "/files/run.sh" ]
