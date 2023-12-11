#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 使用.run文件安装cuda
################################################################################

source ./get_options.sh $*

cd $ORIGINAL_PACKAGE_PATH

sh cuda_11.7.1_515.65.01_linux.run --silent --toolkit

echo export PATH=$PATH:/usr/local/cuda/bin >> ~/.bashrc
echo export CUDA_HOME=$CUDA_HOME:/usr/local/cuda >> ~/.bashrc
echo export LD_LIBRARY=$LD_LIBRARY:/usr/local/cuda/lib64 >> ~/.bashrc
source ~/.bashrc
