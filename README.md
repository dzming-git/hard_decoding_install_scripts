# Docker硬解码环境安装脚本(Linux)

## 环境说明

- 显卡：RTX2080Ti
- 显卡驱动： 535.54.03
- 系统：Ubuntu 20.04
- CUDA：11.7.1
- cuDNN：8.9.6
- Video Codec SDK：12.1.14
- OenCV：4.6.0
- NV Codec：11.1.5.3
- FFmpeg：4.2.2
- Python：3.8
- Torch：2.0.0+cu117
- torchvision：0.15.1+cu117

## 安装包下载

您可以通过以下链接下载各个软件包：

- [CUDA下载](https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda_11.7.1_515.65.01_linux.run)
- [cuDNN下载](https://developer.nvidia.com/downloads/compute/cudnn/secure/8.9.6/local_installers/11.x/cudnn-linux-x86_64-8.9.6.50_cuda11-archive.tar.xz)
- [Video Codec SDK下载](https://developer.download.nvidia.com/designworks/video-codec-sdk/secure/12.1/Video_Codec_SDK_12.1.14.zip)
- [OpeCV下载](https://github.com/opencv/opencv/archive/4.6.0.zip)
- [opecv_contrib下载](https://github.com/opencv/opencv_contrib/archive/4.6.0.zip)
- [NV Codec下载](https://github.com/FFmpeg/nv-codec-headers/releases/download/n11.1.5.3/nv-codec-headers-11.1.5.3.tar.gz)
- [FFmpeg下载](https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/ffmpeg/7:4.2.2-1ubuntu1/ffmpeg_4.2.2.orig.tar.xz)
- [Torch下载](https://download.pytorch.org/whl/cu117/torch-2.0.0%2Bcu117-cp38-cp38-linux_x86_64.whl)
- [torchvision下载](https://download.pytorch.org/whl/cu117/torchvision-0.15.1%2Bcu117-cp38-cp38-linux_x86_64.whl)

下载路径为 `./compressed_packages`

```bash
mkdir -p ./compressed_packages
wget -P ./compressed_packages https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda_11.7.1_515.65.01_linux.run
wget -P ./compressed_packages https://developer.nvidia.com/downloads/compute/cudnn/secure/8.9.6/local_installers/11.x/cudnn-linux-x86_64-8.9.6.50_cuda11-archive.tar.xz
wget -P ./compressed_packages https://developer.download.nvidia.com/designworks/video-codec-sdk/secure/12.1/Video_Codec_SDK_12.1.14.zip
wget -P ./compressed_packages https://github.com/opencv/opencv/archive/4.6.0.zip
wget -P ./compressed_packages https://github.com/opencv/opencv_contrib/archive/4.6.0.zip
wget -P ./compressed_packages https://github.com/FFmpeg/nv-codec-headers/releases/download/n11.1.5.3/nv-codec-headers-11.1.5.3.tar.gz
wget -P ./compressed_packages https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/ffmpeg/7:4.2.2-1ubuntu1/ffmpeg_4.2.2.orig.tar.xz
wget -P ./compressed_packages https://download.pytorch.org/whl/cu117/torch-2.0.0%2Bcu117-cp38-cp38-linux_x86_64.whl
wget -P ./compressed_packages https://download.pytorch.org/whl/cu117/torchvision-0.15.1%2Bcu117-cp38-cp38-linux_x86_64.whl
```

## 文件结构

```text
.
├── original_packages
│   ├── cuda_11.7.1_515.65.01_linux.run
│   ├── cudnn-linux-x86_64-8.9.6.50_cuda11-archive.tar.xz
│   ├── ffmpeg_4.2.2.orig.tar.xz
│   ├── nv-codec-headers-11.1.5.3.tar.gz
│   ├── opencv-4.6.0.zip
│   ├── opencv_contrib-4.6.0.zip
│   └── Video_Codec_SDK_12.1.14.zip
└── scripts
    ├── get_gpu_compute.sh
    ├── get_options.sh
    ├── install_all.sh
    ├── install_cuda.sh
    ├── install_cudnn.sh
    ├── install_ffmpeg.sh
    ├── install_opencv.sh
    ├── install_packages.sh
    ├── install_torch.sh
    ├── install_video_coded.sh
    └── test_hard_decoding.py

```

## 安装

### docker容器构建

假设该文件夹地址为 `/home/admin508/dzm/hard_decoding/docker_shared_folder`，创建容器时将该目录通过 `--volume` 挂载到容器

```bash
docker run \
-itd \
--privileged \
--env NVIDIA_DRIVER_CAPABILITIES=video,compute,utility \
--env DEBIAN_FRONTEND=noninteractive \
--name hard_decoding_base \
--volume /home/admin508/dzm/hard_decoding/docker_shared_folder:/volume_folder \
--gpus all \
ubuntu:20.04 \
/bin/bash
```

### 容器内操作

```bash
cd /volume_folder/scripts
bash install_all.sh
```

确认安装完毕后，取消挂载

```bash
umount /volume_folder
rm -r /volume_folder
```

### 常见问题

1. 安装opencv时，报错

```text
=======================================================================
  Couldn't connect to server from the Internet.
  Perhaps direct connections are not allowed in the current network.
  To use proxy please check/specify these environment variables:
  - http_proxy/https_proxy
  - and/or HTTP_PROXY/HTTPS_PROXY
=======================================================================
```

经过统计，共需要从 raw.githubusercontent.com 下载17个文件，可以在网络允许的环境下载完毕，再修改对应cmake文件中下载地址为本地地址

下载地址

```text
https://raw.githubusercontent.com/WeChatCV/opencv_3rdparty/a8b69ccc738421293254aec5ddb38bd523503252/detect.caffemodel
https://raw.githubusercontent.com/WeChatCV/opencv_3rdparty/a8b69ccc738421293254aec5ddb38bd523503252/detect.prototxt
https://raw.githubusercontent.com/WeChatCV/opencv_3rdparty/a8b69ccc738421293254aec5ddb38bd523503252/sr.caffemodel
https://raw.githubusercontent.com/WeChatCV/opencv_3rdparty/a8b69ccc738421293254aec5ddb38bd523503252/sr.prototxt
https://raw.githubusercontent.com/opencv/opencv_3rdparty/34e4206aef44d50e6bbcd0ab06354b52e7466d26/boostdesc_bgm.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/34e4206aef44d50e6bbcd0ab06354b52e7466d26/boostdesc_bgm_bi.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/34e4206aef44d50e6bbcd0ab06354b52e7466d26/boostdesc_bgm_hd.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/34e4206aef44d50e6bbcd0ab06354b52e7466d26/boostdesc_binboost_064.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/34e4206aef44d50e6bbcd0ab06354b52e7466d26/boostdesc_binboost_128.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/34e4206aef44d50e6bbcd0ab06354b52e7466d26/boostdesc_binboost_256.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/34e4206aef44d50e6bbcd0ab06354b52e7466d26/boostdesc_lbgm.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/fccf7cd6a4b12079f73bbfb21745f9babcd4eb1d/vgg_generated_48.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/fccf7cd6a4b12079f73bbfb21745f9babcd4eb1d/vgg_generated_64.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/fccf7cd6a4b12079f73bbfb21745f9babcd4eb1d/vgg_generated_80.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/fccf7cd6a4b12079f73bbfb21745f9babcd4eb1d/vgg_generated_120.i
https://raw.githubusercontent.com/opencv/opencv_3rdparty/8afa57abc8229d611c4937165d20e2a2d9fc5a12/face_landmark_model.dat
https://github.com/NVIDIA/NVIDIAOpticalFlowSDK/archive/edb50da3cf849840d680249aa6dbef248ebce2ca.zip
```

下载完毕后，放在同一个文件夹下（假设为 `/volume_folder/opencv_contrib_sources` ），在运行脚本时添加该选项

```bash
bash install_all.sh -s /volume_folder/opencv_contrib_sources
```

或对opencv单独安装时，可以运行以下指令

```bash
bash install_opencv.sh -s /volume_folder/opencv_contrib_sources
```
