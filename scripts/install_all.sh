#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 一键安装硬解码所需的环境
################################################################################

OPTS=$*
cd "$(cd "$(dirname "$0")" && pwd)"
source get_options.sh $*
if [[ $OPTS != *"-g"* ]]; then
  OPTS="$OPTS -g $GPU_COMPUTE"
fi
echo "$OPTS"

STEPS=(
    install_packages
    install_cuda
    install_torch
    install_cudnn
    install_video_coded
    install_ffmpeg
    install_opencv
)

for step in "${STEPS[@]}" 
do 
  echo step
  bash "./${step}.sh ${OPTS}" >> "../logs/${step}.logs"
done

if $WITH_PYTHON; then
  python3 ./test_hard_decoding.py
fi

# bash ./install_packages.sh     >> ../logs/install_packages.log
# bash ./install_cuda.sh         >> ../logs/install_cuda.log
# bash ./install_torch.sh        >> ../logs/install_torch.log
# bash ./install_cudnn.sh        >> ../logs/install_cudnn.log
# bash ./install_video_coded.sh  >> ../logs/install_video_coded.log
# bash ./install_ffmpeg.sh       >> ../logs/install_ffmpeg.log
# bash ./install_opencv.sh       >> ../logs/install_opencv.log