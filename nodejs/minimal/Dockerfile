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

WORKDIR /app

ARG NODEJS_SELECTOR="18"
ARG NODEJS_16_VERSION="v16.16.0"
ARG NODEJS_16_SHA256SUM_x64="edcb6e9bb049ae365611aa209fc03c4bfc7e0295dbcc5b2f1e710ac70384a8ec"
ARG NODEJS_16_SHA256SUM_arm64="6cb8f1353480646c1cd8ab9911995e5591e1a97811f43ea4ab3e946a57e7c80e"
ARG NODEJS_18_VERSION="v18.6.0"
ARG NODEJS_18_SHA256SUM_x64="6a33e0ad02c9a3ce0ab298bba95055d45df05dfe0810e871ab5087d9f7852017"
ARG NODEJS_18_SHA256SUM_arm64="2f7d5b0e1bd9d52deecbf257cceafdf3c513bec667491c152d08f36317de5714"
RUN <<-EOF
    echo "Install nodejs"

    if [ "${TARGETARCH}" == "amd64" ]; then
      export ARCH="x64"
      export SHA256SUM="NODEJS_${NODEJS_SELECTOR}_SHA256SUM_x64"
    else
      export ARCH="${TARGETARCH}"
      export SHA256SUM="NODEJS_${NODEJS_SELECTOR}_SHA256SUM_${ARCH}"
    fi

    export NODEJS_VERSION="NODEJS_${NODEJS_SELECTOR}_VERSION"

    curl -SLO "https://nodejs.org/dist/${!NODEJS_VERSION}/node-${!NODEJS_VERSION}-linux-${ARCH}.tar.xz"
    echo "Downloaded SHA256: $(sha256sum node-${!NODEJS_VERSION}-linux-${ARCH}.tar.xz)"
    echo "${!SHA256SUM} node-${!NODEJS_VERSION}-linux-${ARCH}.tar.xz" | sha256sum -c -

    tar -xJf "node-${!NODEJS_VERSION}-linux-${ARCH}.tar.xz" -C /usr/local --strip-components=1 --no-same-owner

    ln -s /usr/local/bin/node /usr/local/bin/nodejs

    rm -f node-${!NODEJS_VERSION}-linux-${ARCH}.tar.xz

    node --version
    npm --version
EOF
