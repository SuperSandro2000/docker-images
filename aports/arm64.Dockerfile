FROM supersandro2000/base-alpine:arm64-3.10

RUN apk add --no-cache --no-progress abuild g++ make nano
RUN adduser root abuild \
  && abuild-keygen -ain

COPY  [ "files/abuild-alias.sh", "/etc/profile.d/" ]

WORKDIR /git
CMD [ "bash", "--login" ]
