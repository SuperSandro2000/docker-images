FROM alpine:3.13.0 as git

RUN apk add --no-cache --no-progress \
    git

ARG VERSION=5.0.0.5
RUN git clone --branch $VERSION --depth=1 --recurse-submodules -j2 --shallow-submodules -- https://github.com/JustArchiNET/ArchiSteamFarm.git /src

#-------------------#

FROM node:lts-alpine AS build-node

COPY --from=git [ "/src/ASF-ui", "/app" ]

WORKDIR /app
RUN npm ci \
  && npm run deploy

#-------------------#

FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine AS build-dotnet

ARG STEAM_TOKEN_DUMPER_TOKEN

ENV CONFIGURATION=Release \
  DOTNET_CLI_TELEMETRY_OPTOUT=1 \
  DOTNET_NOLOGO=1 \
  NET_CORE_VERSION=net5.0 \
  STEAM_TOKEN_DUMPER_NAME=ArchiSteamFarm.OfficialPlugins.SteamTokenDumper

COPY --from=build-node [ "/app/dist", "/app/ASF-ui/dist" ]
COPY --from=git [ "/src/ArchiSteamFarm", "/app/ArchiSteamFarm" ]
COPY --from=git [ "/src/ArchiSteamFarm.OfficialPlugins.SteamTokenDumper", "/app/ArchiSteamFarm.OfficialPlugins.SteamTokenDumper" ]
COPY --from=git [ "/src/resources", "/app/resources" ]
COPY --from=git [ "/src/Directory.Build.props", "/app/Directory.Build.props" ]

WORKDIR /app
RUN dotnet --info \
  # TODO: Remove workaround for https://github.com/microsoft/msbuild/issues/3897 when it's no longer needed
  && if [ -f "ArchiSteamFarm/Localization/Strings.zh-CN.resx" ]; then ln -s "Strings.zh-CN.resx" "ArchiSteamFarm/Localization/Strings.zh-Hans.resx"; fi \
  && if [ -f "ArchiSteamFarm/Localization/Strings.zh-TW.resx" ]; then ln -s "Strings.zh-TW.resx" "ArchiSteamFarm/Localization/Strings.zh-Hant.resx"; fi \
  && if [ -n "${STEAM_TOKEN_DUMPER_TOKEN-}" ] && [ -f "${STEAM_TOKEN_DUMPER_NAME}/SharedInfo.cs" ]; then sed -i "s/STEAM_TOKEN_DUMPER_TOKEN/${STEAM_TOKEN_DUMPER_TOKEN}/g" "${STEAM_TOKEN_DUMPER_NAME}/SharedInfo.cs"; fi \
  && dotnet publish "${STEAM_TOKEN_DUMPER_NAME}" -c "$CONFIGURATION" -f "$NET_CORE_VERSION" -o "out/${STEAM_TOKEN_DUMPER_NAME}/${NET_CORE_VERSION}" -p:SelfContained=false -p:UseAppHost=false -r linux-x64 --nologo \
  && dotnet clean ArchiSteamFarm -c "$CONFIGURATION" -f "$NET_CORE_VERSION" -p:SelfContained=false -p:UseAppHost=false -r linux-x64 --nologo \
  && dotnet publish ArchiSteamFarm -c "$CONFIGURATION" -f "$NET_CORE_VERSION" -o "out/result" -p:ASFVariant=linux-x64 -p:PublishSingleFile=true -p:PublishTrimmed=true -r linux-x64 --nologo \
  && if [ -d "ArchiSteamFarm/overlay/linux-x64" ]; then cp "ArchiSteamFarm/overlay/linux-x64/"* "out/result"; fi \
  && if [ -f "out/${STEAM_TOKEN_DUMPER_NAME}/${NET_CORE_VERSION}/${STEAM_TOKEN_DUMPER_NAME}.dll" ]; then mkdir -p "out/result/plugins/${STEAM_TOKEN_DUMPER_NAME}"; cp "out/${STEAM_TOKEN_DUMPER_NAME}/${NET_CORE_VERSION}/${STEAM_TOKEN_DUMPER_NAME}.dll" "out/result/plugins/${STEAM_TOKEN_DUMPER_NAME}"; fi

#-------------------#

FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine AS runtime

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

ENV ASPNETCORE_URLS="" \
	DOTNET_CLI_TELEMETRY_OPTOUT=1 \
	DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1

COPY --from=build-dotnet [ "/app/out/result", "/app" ]

WORKDIR /app
EXPOSE 1242
ENTRYPOINT ["./ArchiSteamFarm.sh", "--no-restart", "--process-required", "--system-required"]
