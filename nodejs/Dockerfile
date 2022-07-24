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
ARG NODEJS_14_VERSION="v14.20.0"
ARG NODEJS_14_SHA256SUM_x64="c3722dc5c0bc90efc0872328f5bb7c602002958e4e7e97c15ec29a96e3ac3b98"
ARG NODEJS_14_SHA256SUM_arm64="8a31a4e78c5c0153d933538017139d0c6554d2b0bb0abe8b87b71a1e1d4bf65d"
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

ARG PNPM_VERSION="v7.5.2"
ARG PNPM_SHA256SUM="26917eb9362e274f5856f784298f0499a8558e4c1d983b10b2dcd2c110a4c7fd"
ARG PNPX_SHA256SUM="61274de80af5f7bcd6b99ecfa8eca8e748633987d2865b52155e798fcf89a6ec"
RUN <<-EOF
    echo "Install pnpm"

    corepack enable pnpm

    corepack prepare --activate pnpm@${PNPM_VERSION}

    echo "Downloaded pnpm SHA256: $(sha256sum /usr/local/lib/node_modules/corepack/dist/pnpm.js)"
    echo "${PNPM_SHA256SUM} /usr/local/lib/node_modules/corepack/dist/pnpm.js" | sha256sum -c -

    echo "Downloaded pnpx SHA256: $(sha256sum /usr/local/lib/node_modules/corepack/dist/pnpx.js)"
    echo "${PNPX_SHA256SUM} /usr/local/lib/node_modules/corepack/dist/pnpx.js" | sha256sum -c -

    pnpm --version
EOF

ARG YARN_VERSION="v3.2.1"
ARG YARN_SHA256SUM="e9666c0609f2dca49435a3f31f020e611f242fd42637994b5f73885c75eb4ab3"
ARG YARNPKG_SHA256SUM="630f7b79a41cf59c75e172aa0661435d5fe2375991ecae4208853ac8b8230b29"
RUN <<-EOF
    echo "Install yarn"

    corepack enable yarn

    corepack prepare --activate yarn@${YARN_VERSION}

    echo "Downloaded yarn SHA256: $(sha256sum /usr/local/lib/node_modules/corepack/dist/yarn.js)"
    echo "${YARN_SHA256SUM} /usr/local/lib/node_modules/corepack/dist/yarn.js" | sha256sum -c -

    echo "Downloaded yarnpkg SHA256: $(sha256sum /usr/local/lib/node_modules/corepack/dist/yarnpkg.js)"
    echo "${YARNPKG_SHA256SUM} /usr/local/lib/node_modules/corepack/dist/yarnpkg.js" | sha256sum -c -

    yarn --version
EOF
