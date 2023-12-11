#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 安装torch torchvision
################################################################################

source ./get_options.sh $*

if  ! $WITH_PYTHON; then
  exit
fi

pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

TORCH_FILES=(
    "torch==2.0.0+cu117"
    "torchvision==0.15.1+cu117"
)

declare -A TORCH_FILES_DICT=(
    ["torch==2.0.0+cu117"]="torch-2.0.0+cu117-cp38-cp38-linux_x86_64.whl"
    ["torchvision==0.15.1+cu117"]="torchvision-0.15.1+cu117-cp38-cp38-linux_x86_64.whl"
)

find_file() {
    local _filename=$1

    # 检查文件是否存在于指定路径
    if [[ -e "${ORIGINAL_PACKAGE_PATH}/${_filename}" ]]; then
        echo "${ORIGINAL_PACKAGE_PATH}/${_filename}"
    else
        # 在整个系统中搜索文件
        result=$(find / -name "${_filename}" 2>/dev/null)
        if [[ -n "${result}" ]]; then
            echo "${result}"
        else
            echo ""  # 找不到返回空的路径
        fi
    fi
}


for pkg in "${TORCH_FILES[@]}"; do
    filename=${TORCH_FILES_DICT[$pkg]}
    path=$(find_file "$filename")
    if [[ -z "$path" ]]; then
        pip3 install $pkg
    else
        pip3 install $path
    fi
done
