ARG PARENT_TAG
FROM --platform=$BUILDPLATFORM registry.gitlab.com/kisev/dockerfiles/core:${PARENT_TAG} AS build

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG BUILDPLATFORM
ARG BUILDOS
ARG BUILDARCH
ARG BUILDVARIANT

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

WORKDIR /build

COPY sources-amd64.list /etc/apt/sources.list
COPY sources-arm64.list .

# hadolint ignore=DL3008
RUN <<-EOF
    echo "Install required system packages"

    if [ "${TARGETARCH}" == "arm64" ]; then
      mv sources-arm64.list /etc/apt/sources.list.d/sources-arm64.list

      dpkg --add-architecture "${TARGETARCH}"

      apt-get update

      apt-get install -y --no-install-recommends \
        software-properties-common

      add-apt-repository ppa:deadsnakes/ppa

      apt-get install -y --no-install-recommends \
        binutils-aarch64-linux-gnu \
        gcc-aarch64-linux-gnu \
        libc-dev-arm64-cross
    else
      apt-get update
    fi

    apt-get install -y --no-install-recommends \
      file \
      build-essential \
      gcc \
      libssl-dev:${TARGETARCH} \
      libbz2-dev:${TARGETARCH} \
      zlib1g-dev:${TARGETARCH} \
      libreadline-dev:${TARGETARCH} \
      libffi-dev:${TARGETARCH} \
      libncurses5-dev:${TARGETARCH} \
      libgdbm-dev:${TARGETARCH} \
      libgdbm-compat-dev:${TARGETARCH} \
      libnss3-dev:${TARGETARCH} \
      tk-dev:${TARGETARCH} \
      libsqlite3-dev:${TARGETARCH} \
      liblzma-dev:${TARGETARCH} \
      uuid-dev:${TARGETARCH} \
      libbluetooth-dev:${TARGETARCH}
EOF

# rm -rf /var/lib/apt/lists/*

ARG PYTHON_SELECTOR="3.10"
ARG PYTHON_3_8_VERSION="3.8.13"
ARG PYTHON_3_8_SHA256SUM="903b92d76354366b1d9c4434d0c81643345cef87c1600adfa36095d7b00eede4"
ARG PYTHON_3_9_VERSION="3.9.13"
ARG PYTHON_3_9_SHA256SUM="829b0d26072a44689a6b0810f5b4a3933ee2a0b8a4bfc99d7c5893ffd4f97c44"
ARG PYTHON_3_10_VERSION="3.10.5"
ARG PYTHON_3_10_SHA256SUM="18f57182a2de3b0be76dfc39fdcfd28156bb6dd23e5f08696f7492e9e3d0bf2d"
# hadolint ignore=DL3003,DL3008
RUN <<-EOF
    echo "Install python"

    # Python required for cross-compiling
    if [ "${TARGETARCH}" == "arm64" ]; then
      apt-get install -y --no-install-recommends \
        python${PYTHON_SELECTOR} \
        python${PYTHON_SELECTOR}-dev
    fi

    export PYTHON_SELECTOR_ENV="$(echo "${PYTHON_SELECTOR}" | tr . _)"
    export PYTHON_VERSION="PYTHON_${PYTHON_SELECTOR_ENV}_VERSION"
    export SHA256SUM="PYTHON_${PYTHON_SELECTOR_ENV}_SHA256SUM"

    curl -SLO "https://www.python.org/ftp/python/${!PYTHON_VERSION}/Python-${!PYTHON_VERSION}.tgz"
    echo "Downloaded SHA256: $(sha256sum Python-${!PYTHON_VERSION}.tgz)"
    echo "${!SHA256SUM} Python-${!PYTHON_VERSION}.tgz" | sha256sum -c -

    tar -xzf "Python-${!PYTHON_VERSION}.tgz"
    rm -f "Python-${!PYTHON_VERSION}.tgz"

    cd Python-${!PYTHON_VERSION}

    if [ "${TARGETARCH}" == "arm64" ]; then
      ./configure \
        ac_cv_buggy_getaddrinfo=no \
        ac_cv_file__dev_ptmx=yes \
        ac_cv_file__dev_ptc=no \
        --build=x86_64-linux-gnu \
        --host=aarch64-linux-gnu \
        --prefix=/build/python \
        --enable-loadable-sqlite-extensions \
        --enable-optimizations \
        --with-lto \
        --without-ensurepip \
      || cat config.log
    else
      ./configure \
        --prefix=/build/python \
        --enable-loadable-sqlite-extensions \
        --enable-optimizations \
        --with-lto \
        --without-ensurepip \
      || cat config.log
    fi

    make -j "$(nproc)" install

    cd ..

    rm -rf "Python-${!PYTHON_VERSION}"

    file "/build/python/bin/python${PYTHON_SELECTOR}"
EOF


ARG PARENT_TAG
FROM registry.gitlab.com/kisev/dockerfiles/core:${PARENT_TAG}

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

WORKDIR /app

ENV PIP_NO_CACHE_DIR="true"

COPY --from=build /build/python /usr/local

ARG PYTHON_SELECTOR="3.10"
RUN <<-EOF
    ln -s "/usr/local/bin/python${PYTHON_SELECTOR}" /usr/local/bin/python
    ln -s "/usr/local/bin/python${PYTHON_SELECTOR}-config" /usr/local/bin/python-config

    python --version
    ldd /usr/local/bin/python
EOF

ARG PIP_VERSION="22.2"
ARG PIP_SHA256SUM="d077d469ce4c0beaf9cc97b73f8164ad20e68e0519f14dd886ce35d053721501"
RUN <<-EOF
    echo "Install pip"

    curl -SLO "https://github.com/pypa/get-pip/raw/${PIP_VERSION}/public/get-pip.py"
    echo "Downloaded SHA256: $(sha256sum get-pip.py)"
    echo "${PIP_SHA256SUM} get-pip.py" | sha256sum -c -

    python get-pip.py \
      --no-setuptools \
      --no-wheel \
      pip=="${PIP_VERSION}"

    rm -f get-pip.py

    pip --version
EOF

COPY pipenv-requirements.txt .

RUN <<-EOF
    echo "Install pipenv"

    pip install \
      --no-cache-dir \
      --require-hashes \
      --requirement pipenv-requirements.txt

    rm -f pipenv-requirements.txt

    pipenv --version
EOF

COPY Pipfile Pipfile.lock ./

RUN <<-EOF
    echo "Install pipx and poetry via pipenv"

    pipenv verify
    pipenv check --system
    pipenv install --system

    rm -f Pipfile Pipfile.lock

    pipx --version
    poetry --version
EOF
