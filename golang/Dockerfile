ARG PARENT_TAG
FROM registry.gitlab.com/kisev/dockerfiles/core:${PARENT_TAG}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV GOPATH=/go
ENV PATH=${PATH}:/usr/local/go/bin:${GOPATH}/bin

ARG GOLANG_VERSION="1.18.3"
ARG GOLANG_SHA256SUM="956f8507b302ab0bb747613695cdae10af99bbd39a90cae522b7c0302cc27245"
RUN echo " ---> Install golang" \
    && \
    curl -SLO "https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" \
    && \
    echo "Downloaded SHA256: $(sha256sum go${GOLANG_VERSION}.linux-amd64.tar.gz)" \
    && \
    echo "${GOLANG_SHA256SUM} go${GOLANG_VERSION}.linux-amd64.tar.gz" | sha256sum -c - \
    && \
    tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz \
    && \
    rm -f go${GOLANG_VERSION}.linux-amd64.tar.gz

ARG GOTESTSUM_VERSION="1.8.1"
ARG GOTESTSUM_SHA256SUM="1b14309e12f0f731b421963063ee1987fec32a4d00ec9906da8de23ddb194505"
RUN echo " ---> Install gotestsum" && \
    curl -SLO "https://github.com/gotestyourself/gotestsum/releases/download/v${GOTESTSUM_VERSION}/gotestsum_${GOTESTSUM_VERSION}_linux_amd64.tar.gz" \
    && \
    echo "Downloaded SHA256: $(sha256sum gotestsum_${GOTESTSUM_VERSION}_linux_amd64.tar.gz)" \
    && \
    echo "${GOTESTSUM_SHA256SUM} gotestsum_${GOTESTSUM_VERSION}_linux_amd64.tar.gz" | sha256sum -c - \
    && \
    mkdir /tmp/gotestsum \
    && \
    tar -C /tmp/gotestsum -xzf gotestsum_${GOTESTSUM_VERSION}_linux_amd64.tar.gz \
    && \
    mv /tmp/gotestsum/gotestsum /usr/local/bin/gotestsum \
    && \
    rm -rf /tmp/gotestsum \
    && \
    rm -f gotestsum_${GOTESTSUM_VERSION}_linux_amd64.tar.gz

ARG GOLANGCI_LINT_VERSION="1.46.2"
ARG GOLANGCI_LINT_SHA256SUM="242cd4f2d6ac0556e315192e8555784d13da5d1874e51304711570769c4f2b9b"
RUN echo " ---> Install golangci-lint" \
    && \
    curl -SLO "https://github.com/golangci/golangci-lint/releases/download/v${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz" \
    && \
    echo "Downloaded SHA256: $(sha256sum golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz)" \
    && \
    echo "${GOLANGCI_LINT_SHA256SUM} golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz" | sha256sum -c - \
    && \
    tar -xzf golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz \
    && \
    mv golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64/golangci-lint /usr/local/bin/golangci-lint \
    && \
    rm -rf golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64*

ARG GOCOVER_COBERTURA_VERSION="v1.2.0"
RUN echo " ---> Install gocover-cobertura" && \
    go install github.com/boumenot/gocover-cobertura@${GOCOVER_COBERTURA_VERSION}
