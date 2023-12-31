#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 安装ffmpeg
################################################################################

cd "$(cd "$(dirname "$0")" && pwd)"
source get_options.sh $*

GPU_COMPUTE=${GPU_COMPUTE//./}

tar -zxvf ${ORIGINAL_PACKAGE_PATH}/nv-codec-headers-11.1.5.3.tar.gz -C ${DECOMPASS_PATH}

cd ${DECOMPASS_PATH}/nv-codec-headers-11.1.5.3
make
make install

tar -xvf ${ORIGINAL_PACKAGE_PATH}/ffmpeg_4.2.2.orig.tar.xz -C ${DECOMPASS_PATH}

cd ${DECOMPASS_PATH}/ffmpeg-4.2.2

# 根据显卡算力修改configure中的参数
sed -i '4237s/.*/    nvccflags_default="-gencode arch=compute_'"${GPU_COMPUTE}"',code=sm_'"${GPU_COMPUTE}"' -O2"/' ./configure
sed -i '4240s/.*/    nvccflags_default="--cuda-gpu-arch=sm_'"${GPU_COMPUTE}"' -O2"/' ./configure

./configure --prefix=/usr/local/ffmpeg --enable-shared --enable-nonfree --enable-gpl --enable-version3 --enable-libmp3lame --enable-libvpx --enable-libopus --enable-opencl --enable-libxcb --enable-avresample --enable-opengl --enable-nvenc --enable-vaapi --enable-vdpau --enable-ffplay --enable-ffprobe --enable-libxvid --enable-libx264 --enable-libx265 --enable-openal --enable-openssl --enable-cuda-nvcc --enable-cuvid --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64
make -j8
make install
ln -s /usr/local/ffmpeg/bin/ffmpeg /usr/bin/ffmpeg
ln -s /usr/local/ffmpeg/bin/ffprobe /usr/bin/ffprobe
ln -s /usr/local/ffmpeg/bin/ffplay /usr/bin/ffplay
ln -s /usr/local/ffmpeg/bin/ffmpeg /usr/local/bin/ffmpeg
ln -s /usr/local/ffmpeg/bin/ffprobe /usr/local/bin/ffprobe
ln -s /usr/local/ffmpeg/bin/ffplay /usr/local/bin/ffplay
ln -sf /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_ops_infer.so.8.9.6 /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_ops_infer.so.8
ln -sf /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_adv_infer.so.8.9.6 /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_adv_infer.so.8
ln -sf /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_ops_train.so.8.9.6 /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_ops_train.so.8
ln -sf /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_cnn_train.so.8.9.6 /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_cnn_train.so.8
ln -sf /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_adv_train.so.8.9.6 /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_adv_train.so.8
ln -sf /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_cnn_infer.so.8.9.6 /usr/local/cuda/targets/x86_64-linux/lib/libcudnn_cnn_infer.so.8
ln -sf /usr/local/cuda/targets/x86_64-linux/lib/libcudnn.so.8.9.6 /usr/local/cuda/targets/x86_64-linux/lib/libcudnn.so.8
echo "/usr/local/ffmpeg/lib" >> /etc/ld.so.conf.d/ffmpeg.conf
ldconfig

ffmpeg -version
