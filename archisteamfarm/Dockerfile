FROM alpine:3.11 as git

RUN apk add --no-cache --no-progress \
    git

ARG VERSION=4.1.2.0
RUN git clone --branch $VERSION --depth=1 --recurse-submodules -j2 --shallow-submodules -- https://github.com/JustArchiNET/ArchiSteamFarm.git /src

#-------------------#

FROM node:lts-alpine AS build-node

COPY --from=git [ "/src/ASF-ui", "/app" ]

WORKDIR /app
RUN npm ci \
  && npm run deploy

#-------------------#

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine AS build-dotnet

ENV CONFIGURATION=Release \
  NET_CORE_VERSION=netcoreapp3.1

COPY --from=git [ "/src/ArchiSteamFarm", "/app/ArchiSteamFarm" ]
COPY --from=git [ "/src/ArchiSteamFarm.Tests", "/app/ArchiSteamFarm.Tests" ]
COPY --from=build-node [ "/app/dist", "/app/ASF-ui/dist" ]

WORKDIR /app
RUN dotnet --info \
  # TODO: Remove workaround for https://github.com/microsoft/msbuild/issues/3897 when it's no longer needed
  && if [ -f "ArchiSteamFarm/Localization/Strings.zh-CN.resx" ]; then ln -s "Strings.zh-CN.resx" "ArchiSteamFarm/Localization/Strings.zh-Hans.resx"; fi \
  && if [ -f "ArchiSteamFarm/Localization/Strings.zh-TW.resx" ]; then ln -s "Strings.zh-TW.resx" "ArchiSteamFarm/Localization/Strings.zh-Hant.resx"; fi \
  && dotnet build ArchiSteamFarm -c "$CONFIGURATION" -f "$NET_CORE_VERSION" /nologo \
  && dotnet test ArchiSteamFarm.Tests -c "$CONFIGURATION" -f "$NET_CORE_VERSION" /nologo \
  && dotnet publish ArchiSteamFarm -c "$CONFIGURATION" -f "$NET_CORE_VERSION" -o 'out' /nologo /p:ASFVariant=docker /p:PublishTrimmed=false /p:UseAppHost=false \
  && cp "ArchiSteamFarm/overlay/generic/ArchiSteamFarm.sh" "out/ArchiSteamFarm.sh"

#-------------------#

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine AS runtime

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/archisteamfarm/" \
  org.opencontainers.image.documentation="https://github.com/JustArchiNET/ArchiSteamFarm/wiki" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="Apache-2.0" \
  org.opencontainers.image.title="ArchiSteamFarm" \
  org.opencontainers.image.description="C# application with primary purpose of idling Steam cards from multiple accounts simultaneously."

ENV ASPNETCORE_URLS=""

COPY --from=build-dotnet [ "/app/out", "/app" ]

WORKDIR /app
EXPOSE 1242
ENTRYPOINT ["./ArchiSteamFarm.sh", "--no-restart", "--process-required", "--system-required"]
