#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 使用.run文件安装cuda
################################################################################

PACKAGES_PATH=$(realpath "..")

cd ${PACKAGES_PATH}

sh cuda_11.7.1_515.65.01_linux.run --silent --toolkit

echo 'export PATH=$PATH:/usr/local/cuda/bin' >> ~/.bashrc
echo 'export CUDA_HOME=$CUDA_HOME:/usr/local/cuda' >> ~/.bashrc
echo 'LD_LIBRARY=$LD_LIBRARY:/usr/local/cuda/lib64' >> ~/.bashrc
source ~/.bashrc

python3 -c "import torch; print(torch.__version__); print(torch.cuda.is_available())"
