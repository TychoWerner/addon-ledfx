#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: ledfx
# Configures ledfx
# ==============================================================================

if ! bashio::fs.directory_exists "/data/ledfx"; then
    bashio::log "Creating config directory"
    mkdir -p /data/ledfx
fi

mkdir -p /root/.ledfx

#Generate config if not exist
if ! bashio::fs.file_exists "/data/ledfx/config.yaml"; then
    bashio::log "Creating default config"
    {
            echo "dev_mode: false"
            echo "devices: []"
            echo "host: 0.0.0.0"
            echo "max_workers: 10"
            echo "port: 8888"
            echo "presets: {}"
    } >> "/data/ledfx/config.yaml"
fi
