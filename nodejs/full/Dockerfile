ARG PARENT_TAG
ARG NODEJS_SELECTOR
FROM registry.gitlab.com/kisev/dockerfiles/nodejs-${NODEJS_SELECTOR}:${PARENT_TAG}-minimal

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDOS
ARG BUILDARCH
ARG BUILDVARIANT

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

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
