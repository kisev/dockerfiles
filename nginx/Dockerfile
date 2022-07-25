ARG PARENT_TAG
FROM registry.gitlab.com/kisev/dockerfiles/core:${PARENT_TAG}

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

ARG NGINX_VERSION="1.23.*"

# hadolint ignore=DL3008
RUN <<-EOF
    echo "Install nginx"

    echo "deb https://nginx.org/packages/mainline/ubuntu/ jammy nginx" >> /etc/apt/sources.list.d/nginx.list
    echo "deb-src https://nginx.org/packages/mainline/ubuntu/ jammy nginx" >> /etc/apt/sources.list.d/nginx.list

    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62

    apt-get update

    apt-get install -y --no-install-recommends \
      gettext-base \
      nginx="${NGINX_VERSION}"

    rm -rf /var/lib/apt/lists/*
    rm -f /etc/nginx/conf.d/*

    ln -sf /dev/stdout /var/log/nginx/access.log
    ln -sf /dev/stderr /var/log/nginx/error.log

    nginx -version
EOF

COPY nginx.conf /etc/nginx/nginx.conf

# Smoke test
RUN test -e /var/run || ln -s /run /var/run && \
    nginx -t

STOPSIGNAL SIGQUIT

ENTRYPOINT ["nginx", "-g", "daemon off;"]
