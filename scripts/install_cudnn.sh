#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 安装cuDNN
################################################################################

PACKAGES_PATH=$(realpath "../packages")

cd "${PACKAGES_PATH}/cudnn-linux-x86_64-8.9.6.50_cuda11-archive"
cp include/*.h /usr/local/cuda/include
cp lib/libcudnn* /usr/local/cuda/lib64
chmod a+r /usr/local/cuda/include/cudnn* /usr/local/cuda/lib64/libcudnn*

# 验证
python3 -c "import torch; print(torch.backends.cudnn.version())"
