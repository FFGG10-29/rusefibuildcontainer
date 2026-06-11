#!/usr/bin/env bash
set -e

# Windows: 确保 Docker 在 PATH 中
export PATH="/c/Program Files/Docker/Docker/resources/bin:$PATH"

mkdir -p repo
chmod u+x *.sh
docker build . -t rusefi_build:0.1 --progress=plain
