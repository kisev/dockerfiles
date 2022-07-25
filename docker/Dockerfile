ARG PARENT_TAG
FROM registry.gitlab.com/kisev/dockerfiles/core:${PARENT_TAG}

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN <<-EOF
    echo "Install required system packages"

    apt-get update
    apt-get install -y --no-install-recommends \
      jq \
      gettext-base \
      gawk \
      colordiff \
      wdiff \
      openssh-client \
      git

    rm -rf /var/lib/apt/lists/*
EOF

ENV DOCKER_TLS_CERTDIR="/certs"

ARG DOCKER_VERSION="20.10.17"
ARG DOCKER_SHA256SUM_x86_64="969210917b5548621a2b541caf00f86cc6963c6cf0fb13265b9731c3b98974d9"
ARG DOCKER_SHA256SUM_aarch64="249244024b507a6599084522cc73e73993349d13264505b387593f2b2ed603e6"
RUN <<-EOF
    echo "Install docker"

    ARCH="$(uname -m)"
    export ARCH
    export SHA256SUM="DOCKER_SHA256SUM_${ARCH}"

    curl -SLO "https://download.docker.com/linux/static/stable/${ARCH}/docker-${DOCKER_VERSION}.tgz"
    echo "Downloaded SHA256: $(sha256sum docker-${DOCKER_VERSION}.tgz)"
    echo "${!SHA256SUM} docker-${DOCKER_VERSION}.tgz" | sha256sum -c -

    tar -xzf "docker-${DOCKER_VERSION}.tgz"
    rm -f "docker-${DOCKER_VERSION}.tgz"

    mv docker/docker /usr/local/bin/docker
    rm -rf docker

    mkdir -p "${DOCKER_TLS_CERTDIR}/client"
    chmod -R 1777 "${DOCKER_TLS_CERTDIR}"

    docker --version
EOF
