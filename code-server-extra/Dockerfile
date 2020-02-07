FROM codercom/code-server:v2

USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
  && apt-get install --no-install-recommends -qy \
    golang \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/SuperSandro2000/install-scripts/raw/master/programs/shellcheck.sh -O- | bash

USER coder
