ARG CURRENT_VERSION_MICRO
ARG VERSION_ALPINE

FROM golang:${CURRENT_VERSION_MICRO}-alpine${VERSION_ALPINE}

# Build-time metadata as defined at https://github.com/opencontainers/image-spec
ARG DATE
ARG CURRENT_VERSION_MICRO
ARG COMMIT
ARG AUTHOR

LABEL \
    org.opencontainers.image.created=$DATE \
    org.opencontainers.image.url="https://hub.docker.com/r/pfillion/drone-golang" \
    org.opencontainers.image.source="https://github.com/pfillion/drone-golang" \
    org.opencontainers.image.version=$CURRENT_VERSION_MICRO \
    org.opencontainers.image.revision=$COMMIT \
    org.opencontainers.image.vendor="pfillion" \
    org.opencontainers.image.title="drone-golang" \
    org.opencontainers.image.description="golang with more tools for Drone.io " \
    org.opencontainers.image.authors=$AUTHOR \
    org.opencontainers.image.licenses="MIT"

RUN apk add --update --no-cache \
    git \
    make \
    libc6-compat