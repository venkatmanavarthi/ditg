FROM ubuntu:16.04 AS build

SHELL ["/bin/bash", "-c"]

RUN <<EOF
  set -euxo pipefail
  apt-get update
  apt-get install -y --no-install-recommends make g++
  rm -rf /var/lib/apt/lists/*
EOF

WORKDIR /

COPY ./src .

RUN <<EOF
    set -euxo pipefail
    make
EOF

FROM ubuntu:16.04 

COPY --from=build /ITGSend/ITGSend /usr/local/bin

ENTRYPOINT [ "ITGSend" ]