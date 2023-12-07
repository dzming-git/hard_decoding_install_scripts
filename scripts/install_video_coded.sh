#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 安装Video Codec SDK
################################################################################

PACKAGES_PATH=$(realpath "..")

cd "${PACKAGES_PATH}/Video_Codec_SDK_12.1.14"

cp Lib/linux/stubs/x86_64/* /usr/local/cuda/lib64/stubs
cp Interface/*.h /usr/local/cuda/include

echo 'export PATH=$PATH:/usr/local/cuda/lib64/stubs' >> ~/.bashrc
source ~/.bashrc
