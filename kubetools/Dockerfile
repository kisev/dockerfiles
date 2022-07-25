ARG PARENT_TAG
FROM registry.gitlab.com/kisev/dockerfiles/core:${PARENT_TAG}

ARG TARGETARCH

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

ARG KUBECTL_VERSION="v1.24.3"
ARG KUBECTL_SHA256SUM_amd64="8a45348bdaf81d46caf1706c8bf95b3f431150554f47d444ffde89e8cdd712c1"
ARG KUBECTL_SHA256SUM_arm64="bdad4d3063ddb7bfa5ecf17fb8b029d5d81d7d4ea1650e4369aafa13ed97149a"
RUN <<-EOF
    echo "Install kubectl"

    export ARCH="${TARGETARCH}"
    export SHA256SUM="KUBECTL_SHA256SUM_${ARCH}"

    curl -SLO "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl"
    echo "Downloaded SHA256: $(sha256sum kubectl)"
    echo "${!SHA256SUM} kubectl" | sha256sum -c -

    mv kubectl /usr/local/bin/kubectl
    chmod +x /usr/local/bin/kubectl

    kubectl version --output=yaml --client=true
EOF

ARG HELM_VERSION="v3.9.1"
ARG HELM_PLUGIN_SECRETS_VERSION="3.14.0"
ARG HELM_PLUGIN_DIFF_VERSION="3.5.0"
ARG HELM_SHA256SUM_amd64="73df7ddd5ab05e96230304bf0e6e31484b1ba136d0fc22679345c0b4bd43f7ac"
ARG HELM_SHA256SUM_arm64="655dbceb4ab4b246af2214e669b9d44e3a35f170f39df8eebdb8d87619c585d1"
RUN <<-EOF
    echo "Install helm"

    export ARCH="${TARGETARCH}"
    export SHA256SUM="HELM_SHA256SUM_${ARCH}"

    curl -SLO "https://get.helm.sh/helm-${HELM_VERSION}-linux-${ARCH}.tar.gz"
    echo "Downloaded SHA256: $(sha256sum helm-${HELM_VERSION}-linux-${ARCH}.tar.gz)"
    echo "${!SHA256SUM} helm-${HELM_VERSION}-linux-${ARCH}.tar.gz" | sha256sum -c -

    tar -xzf "helm-${HELM_VERSION}-linux-${ARCH}.tar.gz"
    rm -rf "helm-${HELM_VERSION}-linux-${ARCH}.tar.gz"

    mv "linux-${ARCH}/helm" /usr/local/bin/helm
    rm -rf "linux-${ARCH}"

    chmod +x /usr/local/bin/helm

    helm version

    helm plugin install https://github.com/jkroepke/helm-secrets --version "${HELM_PLUGIN_SECRETS_VERSION}"
    helm plugin install https://github.com/databus23/helm-diff --version "${HELM_PLUGIN_DIFF_VERSION}"
EOF

ARG HELMFILE_VERSION="0.145.2"
ARG HELMFILE_SHA256SUM_amd64="95981de235334c0774df8101485c7b506cba5f6b0d9d3fa2dc6bf3220d28f45b"
ARG HELMFILE_SHA256SUM_arm64="7cd158b7ade21a538e0509eb6f2ee0c796c7c81012f6e22d9bb5f7565d5dc1c2"
RUN <<-EOF
    echo "Install helmfile"

    export ARCH="${TARGETARCH}"
    export SHA256SUM="HELMFILE_SHA256SUM_${ARCH}"

    curl -SLO "https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_${HELMFILE_VERSION}_linux_${ARCH}.tar.gz"
    echo "Downloaded SHA256: $(sha256sum helmfile_${HELMFILE_VERSION}_linux_${ARCH}.tar.gz)"
    echo "${!SHA256SUM} helmfile_${HELMFILE_VERSION}_linux_${ARCH}.tar.gz" | sha256sum -c -

    tar -xzf "helmfile_${HELMFILE_VERSION}_linux_${ARCH}.tar.gz"
    rm -f "helmfile_${HELMFILE_VERSION}_linux_${ARCH}.tar.gz"

    mv helmfile /usr/local/bin/helmfile
    chmod +x /usr/local/bin/helmfile

    helmfile --version
EOF

ARG HELMWAVE_VERSION="0.19.6"
ARG HELMWAVE_SHA256SUM_amd64="32fc52313edf1663e7be853c2b3db8d6acb4120a2d7ec9171162a012fa6bedf4"
ARG HELMWAVE_SHA256SUM_arm64="d0c689c2f249b7fc308b8eae6d59c671019311fa03949480e0919b6d85aa646e"
RUN <<-EOF
    echo "Install helmwave"

    export ARCH="${TARGETARCH}"
    export SHA256SUM="HELMWAVE_SHA256SUM_${ARCH}"

    curl -SLO "https://github.com/helmwave/helmwave/releases/download/v${HELMWAVE_VERSION}/helmwave_${HELMWAVE_VERSION}_linux_${ARCH}.tar.gz"
    echo "Downloaded SHA256: $(sha256sum helmwave_${HELMWAVE_VERSION}_linux_${ARCH}.tar.gz)"
    echo "${!SHA256SUM} helmwave_${HELMWAVE_VERSION}_linux_${ARCH}.tar.gz" | sha256sum -c -

    tar -xzf "helmwave_${HELMWAVE_VERSION}_linux_${ARCH}.tar.gz"
    rm -f "helmwave_${HELMWAVE_VERSION}_linux_${ARCH}.tar.gz"

    mv helmwave /usr/local/bin/helmwave
    chmod +x /usr/local/bin/helmwave

    helmwave version
EOF

ARG LINKERD_VERSION="2.11.4"
ARG LINKERD_SHA256SUM_amd64="bf8075489353f050d5839c7674f8d1f9dd98a8ede6bb3a77b5942859722b6d15"
ARG LINKERD_SHA256SUM_arm64="d0435b00e5083a25c8e3488843fae61dd239af1283b509fa803cd843340f6367"
RUN <<-EOF
    echo "Install linkerd"

    export ARCH="${TARGETARCH}"
    export SHA256SUM="LINKERD_SHA256SUM_${ARCH}"

    curl -SLO "https://github.com/linkerd/linkerd2/releases/download/stable-${LINKERD_VERSION}/linkerd2-cli-stable-${LINKERD_VERSION}-linux-${ARCH}"
    echo "Downloaded SHA256: $(sha256sum linkerd2-cli-stable-${LINKERD_VERSION}-linux-${ARCH})"
    echo "${!SHA256SUM} linkerd2-cli-stable-${LINKERD_VERSION}-linux-${ARCH}" | sha256sum -c -

    mv "linkerd2-cli-stable-${LINKERD_VERSION}-linux-${ARCH}" /usr/local/bin/linkerd
    chmod +x /usr/local/bin/linkerd

    linkerd version --client
EOF

ARG SOPS_VERSION="v3.7.3"
ARG SOPS_SHA256SUM_amd64="53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb"
ARG SOPS_SHA256SUM_arm64="4945313ed0dfddba52a12ab460d750c91ead725d734039493da0285ad6c5f032"
RUN <<-EOF
    echo "Install sops"

    export ARCH="${TARGETARCH}"
    export SHA256SUM="SOPS_SHA256SUM_${ARCH}"

    curl -SLO "https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.${ARCH}"
    echo "Downloaded SHA256: $(sha256sum sops-${SOPS_VERSION}.linux.${ARCH})"
    echo "${!SHA256SUM} sops-${SOPS_VERSION}.linux.${ARCH}" | sha256sum -c -

    mv "sops-${SOPS_VERSION}.linux.${ARCH}" /usr/local/bin/sops
    chmod +x /usr/local/bin/sops

    sops --version
EOF
