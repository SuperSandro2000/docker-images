FROM supersandro2000/base-alpine:armhf-3.10

RUN apk add --no-cache --no-progress abuild g++ git make nano

RUN adduser root abuild \
  && abuild-keygen -ain

COPY  [ "files/abuild-alias.sh", "/etc/profile.d/" ]

WORKDIR /git
CMD [ "bash", "--login" ]
