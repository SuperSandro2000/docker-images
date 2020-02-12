FROM debian:testing-slim as git

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    wget \
  && rm -rf /var/lib/apt/lists/*

ARG VERSION=0.2.7
RUN wget -q -O JMusicBot-Linux.jar -- https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-Linux.jar

#--------------#

FROM openjdk:11-jre-slim

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/MusicBot" \
  org.opencontainers.image.documentation="https://github.com/jagrosh/MusicBot/wiki/" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="Apache-2.0" \
  org.opencontainers.image.title="MusicBot" \
  org.opencontainers.image.description="🎶 A Discord music bot that's easy to set up and run yourself!"

RUN export user=MusicBot \
  && groupadd -r $user && useradd -r -g $user $user

COPY --from=git /JMusicBot-Linux.jar /JMusicBot-Linux.jar

RUN ln -rs /data/config.txt /config.txt \
  && ln -rs /data/Playlists /Playlists

WORKDIR /data
CMD [ "java", "-Dnogui=true", "-jar", "/JMusicBot-Linux.jar" ]
