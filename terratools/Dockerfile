ARG PARENT_TAG
FROM registry.gitlab.com/kisev/dockerfiles/core:${PARENT_TAG}

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDOS
ARG BUILDARCH
ARG BUILDVARIANT

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
      openssh-client

    rm -rf /var/lib/apt/lists/*
EOF

ARG TERRAFORM_VERSION="1.2.5"
ARG TERRAFORM_SHA256SUM_amd64="281344ed7e2b49b3d6af300b1fe310beed8778c56f3563c4d60e5541c0978f1b"
ARG TERRAFORM_SHA256SUM_arm64="0544420eb29b792444014988018ae77a7c8df6b23d84983728695ba73e38f54a"
# hadolint ignore=DL3008
RUN <<-EOF
    echo "Install terraform"

    export ARCH="${TARGETARCH}"
    export SHA256SUM="TERRAFORM_SHA256SUM_${ARCH}"

    apt-get update
    apt-get install -y --no-install-recommends \
      unzip

    curl -SLO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip"
    echo "Downloaded SHA256: $(sha256sum terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip)"
    echo "${!SHA256SUM} terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip" | sha256sum -c -

    unzip terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip
    rm -f terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip

    mv terraform /usr/local/bin/terraform
    chmod +x /usr/local/bin/terraform

    apt-get purge -y \
      unzip
    rm -rf /var/lib/apt/lists/*

    terraform --version
EOF

ARG TERRAGRUNT_VERSION="v0.38.5"
ARG TERRAGRUNT_SHA256SUM_amd64="5819f5a0164b986a230cdab6599b2021f3421c13e9233d0f8cfdfd3153e427d7"
ARG TERRAGRUNT_SHA256SUM_arm64="1b38bd8a8c9b148cf541194f97fd95ce74a3d58044b628de2a25b77a8f625242"
RUN <<-EOF
    echo "Install terragrunt"

    export ARCH="${TARGETARCH}"
    export SHA256SUM="TERRAGRUNT_SHA256SUM_${ARCH}"

    curl -SLO "https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_${ARCH}"
    echo "Downloaded SHA256: $(sha256sum terragrunt_linux_${ARCH})"
    echo "${!SHA256SUM} terragrunt_linux_${ARCH}" | sha256sum -c -

    mv terragrunt_linux_${ARCH} /usr/local/bin/terragrunt
    chmod +x /usr/local/bin/terragrunt

    terragrunt --version
EOF
