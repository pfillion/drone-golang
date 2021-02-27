FROM golang:1.16.0-alpine3.13

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

ENV CGO_ENABLED 0

RUN apk add --update --no-cache \
    git \
    make