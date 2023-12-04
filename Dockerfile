# hadolint ignore=DL3007
FROM ghcr.io/spacelift-io/runner-terraform:latest AS spacelift

USER root

# hadolint ignore=DL3018
RUN apk add --no-cache git openssl util-linux && \
  curl --fail --silent --show-error --location --output /usr/local/bin/transcrypt https://github.com/elasticdog/transcrypt/raw/v2.2.3/transcrypt \
  && chmod +x /usr/local/bin/transcrypt

USER spacelift
