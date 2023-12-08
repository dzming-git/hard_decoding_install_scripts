#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 使用apt install安装全过程所需要的包
################################################################################

packages=()

# 基础
PACKAGES_BASE=(
  apt-utils
  gcc
  g++
  wget
  cmake
  make
  build-essential
  unzip
  pkg-config
  checkinstall
)

PACKAGES_COMMON={
  net-tools
  gedit
  vim
  iputils-ping
  git
}

# cuda安装需要
PACKAGES_CUDA=(
  libxml2
)

# python
PACKAGES_PYTHON=(
  python3.8
  python3-pip
)

# ffmpeg
PACKAGES_FFMPEG=(
  libfaac-dev
  libgpac-dev
  ladspa-sdk-dev
  libunistring-dev
  libbz2-dev
  libjack-jackd2-dev
  libmp3lame-dev
  libsdl2-dev
  libopencore-amrnb-dev
  libopencore-amrwb-dev
  libvpx-dev
  libx264-dev
  libx265-dev
  libxvidcore-dev
  libopenal-dev
  libopus-dev
  libsdl1.2-dev
  libtheora-dev
  libva-dev
  libvdpau-dev
  libvorbis-dev
  libx11-dev
  libxfixes-dev
  texi2html
  yasm
  zlib1g-dev
  libssl-dev
  libavcodec-dev
  libavformat-dev
  libavutil-dev
  libswscale-dev
)

# opencv
PACKAGES_OPENCV=(
  libgtk2.0-dev
)

PACKAGES_ALL=(
  "${PACKAGES_BASE[@]}"
  "${PACKAGES_COMMON[@]}"
  "${PACKAGES_CUDA[@]}"
  "${PACKAGES_PYTHON[@]}"
  "${PACKAGES_FFMPEG[@]}"
  "${PACKAGES_OPENCV[@]}"
)

apt-get update

for package in "${PACKAGES_ALL[@]}" 
do 
  apt-get install -y "$package"
done

apt-get purge -y --auto-remove
