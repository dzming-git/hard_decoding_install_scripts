#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 使用apt install安装全过程所需要的包
################################################################################

packages=()

# 基础
packages=(
  "${packages[@]}"
  apt-utils
  vim
  gcc
  g++
  wget
  cmake
  make
  build-essential
  unzip
  iputils-ping
  git
  pkg-config
  checkinstall
  net-tools
)

# cuda安装需要
packages=(
  "${packages[@]}"
  libxml2
)

# python
packages=(
  "${packages[@]}"
  python3.8
  python3-pip
)

# ffmpeg
packages=(
  "${packages[@]}"
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
packages=(
  "${packages[@]}"
  libgtk2.0-dev
)

apt-get update

for package in "${packages[@]}" 
do 
  apt-get install -y "$package"
done

apt-get purge -y --auto-remove
