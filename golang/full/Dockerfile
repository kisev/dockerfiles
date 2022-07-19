ARG PARENT_TAG
ARG GOLANG_SELECTOR="1.18"
FROM registry.gitlab.com/kisev/dockerfiles/golang-${GOLANG_SELECTOR}:${PARENT_TAG}-minimal

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDOS
ARG BUILDARCH
ARG BUILDVARIANT

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

ARG GOLANG_SELECTOR="1.18"

ARG GOTESTSUM_VERSION="1.8.1"
ARG GOTESTSUM_SHA256SUM_amd64="1b14309e12f0f731b421963063ee1987fec32a4d00ec9906da8de23ddb194505"
ARG GOTESTSUM_SHA256SUM_arm64="6dfdf23fd134c936ddbaf34bb037153dcfd547f5693d59c263523b9a60ba7d8d"
RUN <<-EOF
    echo "Install gotestsum"

    export ARCH="${TARGETARCH}"
    export SHA256SUM="GOTESTSUM_SHA256SUM_${ARCH}"

    curl -SLO "https://github.com/gotestyourself/gotestsum/releases/download/v${GOTESTSUM_VERSION}/gotestsum_${GOTESTSUM_VERSION}_linux_${ARCH}.tar.gz"
    echo "Downloaded SHA256: $(sha256sum gotestsum_${GOTESTSUM_VERSION}_linux_${ARCH}.tar.gz)"
    echo "${!SHA256SUM} gotestsum_${GOTESTSUM_VERSION}_linux_${ARCH}.tar.gz" | sha256sum -c -

    mkdir /tmp/gotestsum
    tar -C /tmp/gotestsum -xzf gotestsum_${GOTESTSUM_VERSION}_linux_${ARCH}.tar.gz
    mv /tmp/gotestsum/gotestsum /usr/local/bin/gotestsum
    rm -rf /tmp/gotestsum
    rm -f gotestsum_${GOTESTSUM_VERSION}_linux_${ARCH}.tar.gz

    gotestsum --version
EOF

ARG GOCOVER_COBERTURA_VERSION="v1.2.0"
ARG GOCOVER_COBERTURA_1_17_SHA256SUM_amd64="711ee7b3667a9a339b355daeb0b7e1342bfd39d7aba78b3557f2b37162249c85"
ARG GOCOVER_COBERTURA_1_17_SHA256SUM_arm64="6516375947bf8933d541ec32a315ee3f386924ca46cf2e89276b911af5746670"
ARG GOCOVER_COBERTURA_1_18_SHA256SUM_amd64="b4250ad778ffcb4edb6cba997864fad75d8df404b7e51e37d9d94fd520f1831e"
ARG GOCOVER_COBERTURA_1_18_SHA256SUM_arm64="d9e5794ba818bf8043affde2c5caea5de73bedc5ec3505f63f3b620167b8e2b3"
# hadolint ignore=SC2155
RUN <<-EOF
    echo "Install gocover-cobertura"

    export ARCH="${TARGETARCH}"
    export GOLANG_SELECTOR_ENV=$(echo "${GOLANG_SELECTOR}" | tr . _)
    export SHA256SUM="GOCOVER_COBERTURA_${GOLANG_SELECTOR_ENV}_SHA256SUM_${ARCH}"

    go install github.com/boumenot/gocover-cobertura@${GOCOVER_COBERTURA_VERSION}

    echo "Builded SHA256: $(sha256sum /go/bin/gocover-cobertura)"
    echo "${!SHA256SUM} /go/bin/gocover-cobertura" | sha256sum -c -

    rm -rf /go/pkg
EOF
