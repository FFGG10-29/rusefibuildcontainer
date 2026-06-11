#!/usr/bin/env bash
set -e

# 配置 apt 代理（通过环境变量 HTTP_PROXY 传入）
if [ -n "$HTTP_PROXY" ]; then
    echo "Acquire::http::Proxy \"$HTTP_PROXY\";" > /etc/apt/apt.conf.d/99proxy
    echo "Acquire::https::Proxy \"$HTTPS_PROXY\";" >> /etc/apt/apt.conf.d/99proxy
    echo "Using proxy: $HTTP_PROXY"
fi

# 更新包索引
apt-get -y update

# 安装基础工具链和依赖
apt-get -y install sudo git curl xz-utils openjdk-21-jdk-headless
apt-get -y install make
apt-get -y install gcc-multilib g++-multilib g++-mingw-w64 gcc-mingw-w64 sshpass mtools zip dosfstools
apt-get -y install build-essential gcc gdb gcc-multilib make openjdk-11-jdk-headless xxd nano rsync wget
apt-get -y install libncurses-dev libarchive-zip-perl bsdextrautils
apt-get -y install python3-pip python3 python3-pandas openjfx libopenjfx-java
pip3 install --break-system-packages pyyaml jinja2

# 安装 ARM GCC 工具链
chmod +x /provide_gcc.sh
/provide_gcc.sh
