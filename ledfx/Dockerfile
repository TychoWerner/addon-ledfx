ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:10.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /tmp/

# Setup base
ARG BUILD_ARCH=amd64
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r2 \
        cython=0.29.22-r2 \
        openblas-dev=0.3.15-r0 \
        py3-numpy-dev=1.20.3-r0 \
        python3-dev=3.9.5-r1 \
        zlib-dev=1.2.11-r3 \
    && apk add --no-cache \
        alsa-plugins-pulse=1.2.2-r1 \
        ffmpeg-libs=4.4-r1 \
        nginx=1.20.1-r3 \
        openblas=0.3.15-r0 \
        portaudio-dev=190600.20161030-r1 \
        pulseaudio-alsa=14.2-r5 \
        pulseaudio=14.2-r5 \
        py3-numpy=1.20.3-r0 \
        py3-pip=20.3.4-r1 \
        py3-pynacl=1.4.0-r1 \
        python3=3.9.5-r1 \
    \
    && pip3 install \
        --find-links "https://wheels.home-assistant.io/alpine-3.14/${BUILD_ARCH}/" \
        --no-cache-dir -r /tmp/requirements.txt \
    \
    && apk del --no-cache --purge .build-dependencies \
    && rm -fr \
        /etc/nginx \
        /root/.cache \
        /tmp/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Paul Sinclair <hello@addons.community>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Paul Sinclair <hello@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
