ARG VERSION=3.13
FROM supersandro2000/base-alpine:$VERSION

RUN apk add --no-cache --no-progress \
    abuild \
    g++ \
    git \
    make \
    vim

RUN adduser root abuild \
  && abuild-keygen -ain

COPY [ "files/abuild-alias.sh", "/etc/profile.d/" ]

WORKDIR /git
CMD [ "bash", "--login" ]
