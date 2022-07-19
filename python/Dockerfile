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

# hadolint ignore=DL3008
RUN <<-EOF
    echo "Install required system packages"

    apt-get update
    apt-get install -y --no-install-recommends \
      build-essential \
      gcc \
      g++ \
      libssl-dev \
      libbz2-dev \
      zlib1g-dev \
      libreadline-dev \
      libffi-dev \
      libncurses5-dev \
      libgdbm-dev \
      libgdbm-compat-dev \
      libnss3-dev \
      tk-dev \
      libsqlite3-dev \
      liblzma-dev \
      uuid-dev \
      libmysqlclient-dev \
      libpq-dev

    rm -rf /var/lib/apt/lists/*
EOF

ARG PYTHON_SELECTOR="3_10"
ARG PYTHON_3_9_VERSION="3.9.13"
ARG PYTHON_3_9_SHA256SUM="829b0d26072a44689a6b0810f5b4a3933ee2a0b8a4bfc99d7c5893ffd4f97c44"
ARG PYTHON_3_10_VERSION="3.10.5"
ARG PYTHON_3_10_SHA256SUM="18f57182a2de3b0be76dfc39fdcfd28156bb6dd23e5f08696f7492e9e3d0bf2d"
# hadolint ignore=DL3003
RUN <<-EOF
    echo "Install python"

    export ARCH="${TARGETARCH}"
    export PYTHON_VERSION="PYTHON_${PYTHON_SELECTOR}_VERSION"
    export PYTHON_BASE_VERSION=$(echo "${PYTHON_SELECTOR}" | tr _ .)
    export SHA256SUM="PYTHON_${PYTHON_SELECTOR}_SHA256SUM"

    curl -SLO "https://www.python.org/ftp/python/${!PYTHON_VERSION}/Python-${!PYTHON_VERSION}.tgz"
    echo "Downloaded SHA256: $(sha256sum Python-${!PYTHON_VERSION}.tgz)"
    echo "${!SHA256SUM} Python-${!PYTHON_VERSION}.tgz" | sha256sum -c -

    tar -xzf Python-${!PYTHON_VERSION}.tgz
    rm -f Python-${!PYTHON_VERSION}.tgz

    cd Python-${!PYTHON_VERSION}

    ./configure \
      --build="${ARCH}" \
      --enable-loadable-sqlite-extensions \
      --enable-optimizations \
      --with-lto \
      --with-ensurepip=no

    make -j "$(nproc)" altinstall

    cd ..

    rm -rf Python-${!PYTHON_VERSION}

    ln -s /usr/local/bin/python${PYTHON_BASE_VERSION} /usr/local/bin/python
    ln -s /usr/local/bin/python${PYTHON_BASE_VERSION}-config /usr/local/bin/python-config

    python --version
EOF

ARG GETPIP_VERSION="22.1.2"
ARG GETPIP_SHA256SUM="ba3ab8267d91fd41c58dbce08f76db99f747f716d85ce1865813842bb035524d"
ARG SETUPTOOLS_VERSION="63.2.0"
ARG WHEEL_VERSION="0.37.1"
RUN <<-EOF
    echo "Install pip"

    curl -SLO "https://github.com/pypa/get-pip/raw/${GETPIP_VERSION}/public/get-pip.py"
    echo "Downloaded SHA256: $(sha256sum get-pip.py)"
    echo "${GETPIP_SHA256SUM} get-pip.py" | sha256sum -c -

    python get-pip.py \
      pip=="${GETPIP_VERSION}" \
      setuptools=="${SETUPTOOLS_VERSION}" \
      wheel=="${WHEEL_VERSION}"

    rm -f get-pip.py

    pip --version
EOF

ARG PIPENV_VERSION="2022.7.4"
RUN <<-EOF
    echo "Install pipenv"

    pip install --no-cache-dir \
      pipenv=="${PIPENV_VERSION}"

    pipenv --version
EOF

ARG PIPX_VERSION="1.1.0"
RUN <<-EOF
    echo "Install pipx"

    pip install --no-cache-dir \
      pipx=="${PIPX_VERSION}"

    pipx --version
EOF

ARG POETRY_VERSION="1.1.14"
RUN <<-EOF
    echo "Install poetry"

    pip install --no-cache-dir \
      poetry=="${POETRY_VERSION}"

    poetry --version
EOF
