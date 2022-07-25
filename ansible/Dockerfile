ARG PARENT_TAG
FROM registry.gitlab.com/kisev/dockerfiles/python-3.10:${PARENT_TAG} AS build

ARG TARGETARCH

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

WORKDIR /ansible

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

ARG ANSIBLE_SELECTOR="2.13"

COPY ${ANSIBLE_SELECTOR}/Pipfile ${ANSIBLE_SELECTOR}/Pipfile.lock ./

# hadolint ignore=DL3008
RUN <<-EOF
    echo "Install Ansible and required dependencies"

    if [ "${TARGETARCH}" == "arm64" ]; then
      apt-get update

      apt-get install -y --no-install-recommends \
        binutils-aarch64-linux-gnu \
        gcc-aarch64-linux-gnu \
        libc-dev-arm64-cross \
        linux-libc-dev-arm64-cross \
        libc6-dev-arm64-cross \
        libc6-arm64-cross
    fi

    pipenv verify
    pipenv check --system
    pipenv install --system

    rm -f Pipfile Pipfile.lock

    if [ "${TARGETARCH}" == "arm64" ]; then \
      apt-get purge -y \
        binutils-aarch64-linux-gnu \
        gcc-aarch64-linux-gnu \
        libc-dev-arm64-cross \
        linux-libc-dev-arm64-cross \
        libc6-dev-arm64-cross \
        libc6-arm64-cross

      apt-get autoremove -y
    fi

    rm -rf /var/lib/apt/lists/*

    ansible --version
    ansible-lint --version
    molecule --version
    yamllint --version
EOF
