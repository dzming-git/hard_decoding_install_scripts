# Docker硬解码环境安装脚本(Linux)

## 环境说明

- 显卡：RTX2080Ti
- 显卡驱动： 535.54.03
- 系统：Ubuntu 20.04
- CUDA：11.7.1
- cuDNN：8.9.6
- Video Codec SDK：12.1.14
- opencv：4.6.0
- nv codec：11.1.5.3
- ffmpeg：4.2.2
- python：3.8
- torch：2.0.0+cu117
- torchvision：0.15.1+cu117

## 安装包下载

您可以通过以下链接下载各个软件包：

- [CUDA下载](https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda_11.7.1_515.65.01_linux.run)
- [cuDNN下载](https://developer.nvidia.com/downloads/compute/cudnn/secure/8.9.6/local_installers/11.x/cudnn-linux-x86_64-8.9.6.50_cuda11-archive.tar.xz)
- [Video Codec SDK下载](https://developer.download.nvidia.com/designworks/video-codec-sdk/secure/12.1/Video_Codec_SDK_12.1.14.zip)
- [opecv下载](https://github.com/opencv/opencv/archive/4.6.0.zip)
- [opecv_contrib下载](https://github.com/opencv/opencv_contrib/archive/4.6.0.zip)
- [nv codec下载](https://github.com/FFmpeg/nv-codec-headers/releases/download/n11.1.5.3/nv-codec-headers-11.1.5.3.tar.gz)
- [FFmpeg下载](https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/ffmpeg/7:4.2.2-1ubuntu1/ffmpeg_4.2.2.orig.tar.xz)
- [Torch下载](https://download.pytorch.org/whl/cu117/torch-2.0.0%2Bcu117-cp38-cp38-linux_x86_64.whl)
- [Torchvision下载](https://download.pytorch.org/whl/cu117/torchvision-0.15.1%2Bcu117-cp38-cp38-linux_x86_64.whl)

解压缩之后，放在与 `scripts` 同级目录下。

## 文件结构

.
├── cuda_11.7.1_515.65.01_linux.run
├── cudnn-linux-x86_64-8.9.6.50_cuda11-archive
├── ffmpeg-4.2.2
├── nv-codec-headers-11.1.5.3
├── opencv-4.6.0
├── opencv_contrib-4.6.0
├── scripts
├── torch-2.0.0+cu117-cp38-cp38-linux_x86_64.whl
├── torchvision-0.15.1+cu117-cp38-cp38-linux_x86_64.whl
├── Video_Codec_SDK_11.1.5
└── Video_Codec_SDK_12.1.14

## 安装

```bash
cd ./scripts
bash install_all.sh
```
