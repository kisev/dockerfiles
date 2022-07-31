FROM ubuntu:22.04

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

ENV DEBIAN_FRONTEND="noninteractive"

# hadolint ignore=DL3008
RUN <<-EOF
    echo "Install required system packages"

    apt-get update

    apt-get install -y --no-install-recommends \
      apt-utils

    apt-get upgrade -y --no-install-recommends

    apt-get install -y --no-install-recommends \
      ca-certificates \
      locales \
      locales-all \
      tzdata \
      curl \
      gnupg \
      xz-utils

    rm -rf /var/lib/apt/lists/*
EOF

ARG TZ="UTC"
ENV TZ="${TZ}"

ARG LANG="en_US.UTF-8"
ENV LANG="${LANG}"

ARG DUMB_INIT_VERSION="1.2.5"
ARG DUMB_INIT_SHA256SUM_x86_64="e874b55f3279ca41415d290c512a7ba9d08f98041b28ae7c2acb19a545f1c4df"
ARG DUMB_INIT_SHA256SUM_aarch64="b7d648f97154a99c539b63c55979cd29f005f88430fb383007fe3458340b795e"
RUN <<-EOF
    echo "Install dumb-init"

    ARCH="$(uname -m)"
    export ARCH
    export SHA256SUM="DUMB_INIT_SHA256SUM_${ARCH}"

    curl -SLO "https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_${ARCH}"
    echo "Downloaded SHA256: $(sha256sum dumb-init_${DUMB_INIT_VERSION}_${ARCH})"
    echo "${!SHA256SUM} dumb-init_${DUMB_INIT_VERSION}_${ARCH}" | sha256sum -c -

    mv "dumb-init_${DUMB_INIT_VERSION}_${ARCH}" /usr/local/bin/dumb-init
    chmod +x /usr/local/bin/dumb-init

    dumb-init --version
EOF

ARG TARGETARCH

ARG GOSU_VERSION="1.14"
ARG GOSU_SHA256SUM_amd64="bd8be776e97ec2b911190a82d9ab3fa6c013ae6d3121eea3d0bfd5c82a0eaf8c"
ARG GOSU_SHA256SUM_arm64="73244a858f5514a927a0f2510d533b4b57169b64d2aa3f9d98d92a7a7df80cea"
RUN <<-EOF
    echo "Install gosu"

    export ARCH="${TARGETARCH}"
    export SHA256SUM="GOSU_SHA256SUM_${ARCH}"

    curl -SLO "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${ARCH}"
    echo "Downloaded SHA256: $(sha256sum gosu-${ARCH})"
    echo "${!SHA256SUM} gosu-${ARCH}" | sha256sum -c -

    mv "gosu-${ARCH}" /usr/local/bin/gosu
    chmod +x /usr/local/bin/gosu

    gosu --version
EOF
