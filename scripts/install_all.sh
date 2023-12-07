#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 一键安装硬解码所需的环境
################################################################################

bash ./install_packages.sh
bash ./install_cuda.sh
bash ./install_torch.sh
bash ./install_cudnn.sh
bash ./install_video_coded.sh
bash ./install_ffmpeg.sh
bash ./install_opencv.sh
