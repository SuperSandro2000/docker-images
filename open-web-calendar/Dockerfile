FROM alpine:3.11 as source

RUN apk add --no-cache --no-progress \
    git

ARG SHA

RUN git clone https://github.com/niccokunzmann/open-web-calendar.git /app/

#------------------#

FROM supersandro2000/base-alpine:3.11

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/open-web-calendar" \
  org.opencontainers.image.documentation="https://github.com/healthchecks/open-web-calendar/" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="GPL-2.0" \
  org.opencontainers.image.title="Open Web Calendar" \
  org.opencontainers.image.description="Embed a highly customizable web calendar into your website using iCal source links"

RUN export user=owc \
  && addgroup -S $user && adduser -D -S $user -G $user

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]

RUN apk add --no-cache --no-progress \
    python3

COPY --from=source [ "/app/requirements.txt", "/app/requirements.txt" ]

RUN pip3 install --no-cache-dir --progress-bar off -r /app/requirements.txt

COPY --from=source [ "/app/", "/app/" ]
RUN printf "\
bind = \"0.0.0.0:3000\"\n\
workers = 4\n\
" >/app/gunicorn.py

EXPOSE 3000
WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "gunicorn", "-c", "/app/gunicorn.py", "app:app" ]
