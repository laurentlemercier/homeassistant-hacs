#!/bin/sh

set -eu

TARGET="/config/custom_components/hacs"

echo "------------------------------------------"
echo " Home Assistant HACS bootstrap"
echo "------------------------------------------"

if [ -f "${TARGET}/manifest.json" ]; then
    echo "HACS already installed."
    exit 0
fi

echo "Installing HACS..."

mkdir -p /config/custom_components

cp -R /opt/hacs "${TARGET}"

echo "Done."

exit 0
