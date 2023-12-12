#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 安装opencv
################################################################################

cd "$(cd "$(dirname "$0")" && pwd)"
source get_options.sh $*

OPENCV_VERSION="4.6.0"

cd $ORIGINAL_PACKAGE_PATH

unzip -n opencv-${OPENCV_VERSION}.zip -d ${DECOMPASS_PATH}
unzip -n opencv_contrib-${OPENCV_VERSION}.zip -d ${DECOMPASS_PATH}

if [ -n "$OPENCV_CONTRIB_SOURCES" ]; then
  cd $DECOMPASS_PATH/opencv_contrib-$OPENCV_VERSION/modules
  sed -i '27s#.*#"file://'"$OPENCV_CONTRIB_SOURCES"'/"#' xfeatures2d/cmake/download_boostdesc.cmake
  sed -i '21s#.*#"file://'"$OPENCV_CONTRIB_SOURCES"'/"#' xfeatures2d/cmake/download_vgg.cmake
  sed -i '17s#.*#URL "file://'"$OPENCV_CONTRIB_SOURCES"'/"#' cudaoptflow/CMakeLists.txt
  sed -i '19s#.*#"file://'"$OPENCV_CONTRIB_SOURCES"'/"#' face/CMakeLists.txt
  sed -i '31s#.*#"file://'"$OPENCV_CONTRIB_SOURCES"'/"#' wechat_qrcode/CMakeLists.txt
fi

mkdir $DECOMPASS_PATH/opencv-$OPENCV_VERSION/build
cd $DECOMPASS_PATH/opencv-$OPENCV_VERSION/build

CMAKE_OPTIONS="\
-D CMAKE_C_COMPILER=/usr/bin/gcc \
-D CMAKE_CXX_COMPILER=/usr/bin/g++ \
-D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_C_EXAMPLES=ON \
-D BUILD_DOCS=OFF \
-D BUILD_PERF_TESTS=OFF \
-D BUILD_TESTS=OFF \
-D BUILD_PACKAGE=OFF \
-D BUILD_EXAMPLES=OFF \
-D WITH_TBB=ON \
-D ENABLE_FAST_MATH=1 \
-D CUDA_FAST_MATH=1 \
-D WITH_CUDA=ON \
-D WITH_CUBLAS=ON \
-D WITH_CUFFT=ON \
-D WITH_NVCUVID=ON \
-D WITH_IPP=OFF \
-D WITH_V4L=ON \
-D WITH_1394=OFF \
-D WITH_GTK=ON \
-D WITH_QT=OFF \
-D WITH_OPENGL=ON \
-D WITH_EIGEN=ON \
-D WITH_FFMPEG=ON \
-D WITH_GSTREAMER=ON \
-D BUILD_JAVA=OFF \
-D BUILD_opencv_cudacodec=ON \
-D BUILD_opencv_python2=OFF \
-D BUILD_NEW_PYTHON_SUPPORT=ON \
-D OPENCV_SKIP_PYTHON_LOADER=ON \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D OPENCV_EXTRA_MODULES_PATH="$DECOMPASS_PATH/opencv_contrib-$OPENCV_VERSION/modules" \
-D WITH_CUDNN=ON \
-D OPENCV_DNN_CUDA=ON \
-D CUDA_ARCH_BIN="$GPU_COMPUTE" \
-D CUDA_ARCH_PTX="$GPU_COMPUTE" \
-D CUDA_TOOLKIT_ROOT_DIR="/usr/local/cuda/" \
-D CUDA_nppicom_LIBRARY=stdc++ \
"

if $WITH_PYTHON; then
  PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")
  CMAKE_OPTIONS="$CMAKE_OPTIONS \
  -D BUILD_opencv_python3=ON \
  -D PYTHON_DEFAULT_EXECUTABLE=$(python3 -c "import sys; print(sys.executable)") \
  -D PYTHON3_EXECUTABLE=$(python3 -c "import sys; print(sys.executable)") \
  -D PYTHON3_NUMPY_INCLUDE_DIRS=$(python3 -c "import numpy; print (numpy.get_include())") \
  -D PYTHON3_PACKAGES_PATH=$PYTHON3_PACKAGES_PATH  \
  -D PYTHON3_LIBRARY=$(python3 -c "from distutils.sysconfig import get_config_var;from os.path import dirname,join ; print(join(dirname(get_config_var('LIBPC')),get_config_var('LDLIBRARY')))") \
  "
fi

cmake $CMAKE_OPTIONS ..

make all -j$(grep -c ^processor /proc/cpuinfo)
make install -j$(grep -c ^processor /proc/cpuinfo)

if $WITH_PYTHON; then
  echo export PYTHONPATH='$PYTHONPATH':$PYTHON3_PACKAGES_PATH >> ~/.bashrc
  source ~/.bashrc
  echo "opencv_gpu测试 显卡数量：$(python3 -c "import cv2; print(cv2.cuda.getCudaEnabledDeviceCount())")"
fi