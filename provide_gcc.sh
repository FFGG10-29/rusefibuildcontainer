#!/usr/bin/env bash

# Download and extract GCC arm-none-eabi toolchain

set -e

# ARM GCC 14.2.rel1 toolchain
URL="https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz"
MANIFEST_SUM="d7145e6152652d550651e1ceeb9eea86"
COLLOQUIAL="gcc-arm-none-eabi"
TMP_DIR="/tmp/rusefi-provide_gcc14"

archive="${URL##*/}"
SWD="$PWD"

# Download and extract
rm -rf "${TMP_DIR}"
echo "Downloading and extracting ${archive}..."
mkdir -p "${TMP_DIR}"
cd "${TMP_DIR}"

# Use proxy if set
CURL_OPTS="-L"
if [ -n "$HTTPS_PROXY" ]; then
    CURL_OPTS="$CURL_OPTS --proxy $HTTPS_PROXY"
    echo "Using proxy: $HTTPS_PROXY"
fi
curl $CURL_OPTS -o "${archive}" "${URL}"
tar -xaf "${archive}"
echo "Cleaning ${archive}"
rm "${archive}"

# Link all arm-none-eabi-* binaries to /usr/bin/
cd "$SWD"
echo "Linking arm-none-eabi tools to /usr/bin/..."
for f in "${TMP_DIR}"/*/bin/arm-none-eabi-"*"; do
	if [ -f "$f" ]; then
		ln -sf "$f" /usr/bin/
	fi
done

# Verify installation
echo "GCC version:"
arm-none-eabi-gcc --version || echo "WARNING: arm-none-eabi-gcc not found"
