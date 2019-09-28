FROM debian:sid

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

RUN groupadd -r reddiscord && useradd -g reddiscord -r reddiscord

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy default-jre-headless git libffi-dev libssl-dev \
    python3-dev python3-levenshtein python3-multidict python3-pip python3-setuptools python3-yarl unzip wget zip \
  && rm -rf /var/lib/apt/lists/*

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY [ "files/config.json", "/root/.config/Red-DiscordBot/" ]

RUN apt-get update -q \
  && apt-get install --no-install-recommends -qy build-essential \
  && pip3 install --no-cache-dir --progress-bar off https://github.com/Cog-Creators/Red-DiscordBot/archive/V3/develop.tar.gz#egg=Red-DiscordBot \
  && apt-get autoremove -qy --purge build-essential \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "redbot", "docker" ]
