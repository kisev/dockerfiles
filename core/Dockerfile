FROM ubuntu:22.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND="noninteractive"

# hadolint ignore=DL3008
RUN \
    echo " ---> Install required system packages" \
    && \
    apt-get update \
    && \
    apt-get install -y --no-install-recommends \
      apt-utils \
    && \
    apt-get upgrade -y --no-install-recommends \
    && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      locales \
      locales-all \
      tzdata \
      curl \
      gnupg \
    && \
    rm -rf /var/lib/apt/lists/*

ARG TZ="UTC"
ENV TZ="${TZ}"

ARG LANG="en_US.UTF-8"
ENV LANG="${LANG}"

ARG CORE_DUMB_INIT_VERSION="1.2.5"
ARG CORE_DUMB_INIT_SHA256SUM="e874b55f3279ca41415d290c512a7ba9d08f98041b28ae7c2acb19a545f1c4df"
RUN \
    echo " ---> Install dumb-init" \
    && \
    curl -SLO "https://github.com/Yelp/dumb-init/releases/download/v${CORE_DUMB_INIT_VERSION}/dumb-init_${CORE_DUMB_INIT_VERSION}_x86_64" \
    && \
    echo "Downloaded SHA256: $(sha256sum dumb-init_${CORE_DUMB_INIT_VERSION}_x86_64)" \
    && \
    echo "${CORE_DUMB_INIT_SHA256SUM} dumb-init_${CORE_DUMB_INIT_VERSION}_x86_64" | sha256sum -c - \
    && \
    mv dumb-init_${CORE_DUMB_INIT_VERSION}_x86_64 /usr/local/bin/dumb-init \
    && \
    chmod +x /usr/local/bin/dumb-init

ARG CORE_GOSU_VERSION="1.14"
ARG CORE_GOSU_SHA256SUM="bd8be776e97ec2b911190a82d9ab3fa6c013ae6d3121eea3d0bfd5c82a0eaf8c"
RUN \
    echo " ---> Install gosu" \
    && \
    curl -SLO "https://github.com/tianon/gosu/releases/download/${CORE_GOSU_VERSION}/gosu-amd64" \
    && \
    echo "Downloaded SHA256: $(sha256sum gosu-amd64)" \
    && \
    echo "${CORE_GOSU_SHA256SUM} gosu-amd64" | sha256sum -c - \
    && \
    mv gosu-amd64 /usr/local/bin/gosu \
    && \
    chmod +x /usr/local/bin/gosu
