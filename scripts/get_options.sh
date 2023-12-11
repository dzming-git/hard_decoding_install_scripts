#!/bin/bash

WITH_PYTHON=false
ORIGINAL_PACKAGE_PATH=$(realpath "../original_packages")
DECOMPASS_PATH=$HOME
RESERVER_DECOMPASS_FOLDER=false
GPU_COMPUTE=0

help() {
    echo "Usage:"
    echo "install_all.sh [-p] [-o ORIGINAL_PACKAGE_PATH] [-d DECOMPASS_PATH] [-r]"
    echo "Description:"
    echo "-p: Install Python related environments"
    echo "-o ORIGINAL_PACKAGE_PATH: Specify the original package path (default: ${ORIGINAL_PACKAGE_PATH})"
    echo "-d DECOMPASS_PATH: Specify the decompress path (default: ${DECOMPASS_PATH})"
    echo "-r: Reserve the decompress folder"
    echo "-c: GPU Compute Capability, Search on https://developer.nvidia.com/cuda-gpus, if this parameter is not set, intelligent matching will be performed"
    exit -1
}

while getopts "po:d:rhc:" OPT; do
    case $OPT in
        p) 
          WITH_PYTHON=true
          ;;
        o) 
          ORIGINAL_PACKAGE_PATH=$OPTARG
          ;;
        d) 
          DECOMPASS_PATH=$OPTARG
          ;;
        r)
          RESERVER_DECOMPASS_FOLDER=true
          ;;
        h)
          help
          ;;
        c)
          GPU_COMPUTE=$OPTARG
          ;;
        \?)
          echo "Invalid option: -$OPTARG" >&2
          help
          ;;
    esac
done

if (( $GPU_COMPUTE == 0 )); then
  source ./get_gpu_compute.sh
fi

DECOMPASS_PATH="$DECOMPASS_PATH/install_tmp"
mkdir -p $DECOMPASS_PATH

export NO_PYTHON
export ORIGINAL_PACKAGE_PATH
export DECOMPASS_PATH
export RESERVER_DECOMPASS_FOLDER
export GPU_COMPUTE