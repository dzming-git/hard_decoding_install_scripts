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
