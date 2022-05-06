FROM supersandro2000/code-server:4

USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
  && apt-get install --no-install-recommends -qy \
    # go
    gcc \
    golang \
    libc6-dev \
    # misc
    make \
    wget \
  && wget -q -O - -- https://github.com/SuperSandro2000/install-scripts/raw/master/programs/shellcheck.sh | bash \
  && rm -rf /var/lib/apt/lists/*

USER coder
