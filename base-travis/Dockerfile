ARG VERSION=xenial
FROM ubuntu:$VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update \
  && apt-get install --no-install-recommends -qy \
    apt-transport-https \
    gnupg \
    lsb-release \
    software-properties-common \
    wget \
  # backport cmake
  && wget -q -O - -- https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - \
  && apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && apt-get install --no-install-recommends -qy \
    ca-certificates \
    cmake \
    curl \
    docker.io \
    gcc \
    git \
    libssl-dev \
    sudo \
  && rm -rf /var/lib/apt/lists/*

RUN export user=travis \
  && groupadd -r $user && useradd -mr -g $user $user \
  && echo 'ALL ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers \
  \
  # use fake ruby to not get stuck at the caching stage and not install ruby
  && printf "false" >/bin/ruby \
  && chmod +x /bin/ruby \
  \
  && printf "#!/bin/bash\n\
set -eoux pipefail\n\
apt-get update -qy\n\
sudo \"\$@\"\n\
" > /usr/local/bin/entrypoint.sh \
  && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "bash", "/run.sh" ]
