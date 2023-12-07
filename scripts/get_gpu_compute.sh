#!/bin/bash

################################################################################
# Author: dzming
# Date: 2023-11-07
# Description: 根据显卡型号得到算力数值
################################################################################

# 显卡算力表格
declare -A GPU_COMPUTE_MAP=(
    ["GeForce RTX 4090"]=8.9
    ["GeForce RTX 4080"]=8.9
    ["GeForce RTX 4070 Ti"]=8.9
    ["GeForce RTX 4070"]=8.9
    ["GeForce RTX 4060"]=8.9
    ["GeForce RTX 4050"]=8.9
    ["GeForce RTX 3090 Ti"]=8.6
    ["GeForce RTX 3090"]=8.6
    ["GeForce RTX 3080 Ti"]=8.6
    ["GeForce RTX 3080"]=8.6
    ["GeForce RTX 3070 Ti"]=8.6
    ["GeForce RTX 3070"]=8.6
    ["Geforce RTX 3060 Ti"]=8.6
    ["Geforce RTX 3060"]=8.6
    ["Geforce RTX 3050 Ti"]=8.6
    ["Geforce RTX 3050"]=8.6
    ["GeForce GTX 1650 Ti"]=7.5
    ["NVIDIA TITAN RTX"]=7.5
    ["Geforce RTX 2080 Ti"]=7.5
    ["Geforce RTX 2080"]=7.5
    ["Geforce RTX 2070"]=7.5
    ["Geforce RTX 2060"]=7.5
    ["Geforce RTX 1080 Ti"]=6.1
    ["Geforce RTX 1080"]=6.1
    ["Geforce RTX 1070 Ti"]=6.1
    ["Geforce RTX 1060"]=6.1
    ["Geforce RTX 1050"]=6.1
)

# 计算两个字符串之间的最小编辑距离
function calculate_edit_distance() {
    local str1="${1,,}"  # 转换为小写
    local str2="${2,,}"  # 转换为小写
    local len1=${#str1}
    local len2=${#str2}

    # 初始化二维数组
    declare -A dp
    for ((i=0; i<=len1; i++)); do
        dp[$i,0]=$i
    done
    for ((j=0; j<=len2; j++)); do
        dp[0,$j]=$j
    done

    # 动态规划计算最小编辑距离
    for ((i=1; i<=len1; i++)); do
        for ((j=1; j<=len2; j++)); do
            if [[ ${str1:i-1:1} == ${str2:j-1:1} ]]; then
                dp[$i,$j]=${dp[$((i-1)),$((j-1))]}
            else
                dp[$i,$j]=$(( ${dp[$((i-1)),$j]} < ${dp[$i,$((j-1))]} ? ${dp[$((i-1)),$j]} : ${dp[$i,$((j-1))]} ))
                dp[$i,$j]=$(( ${dp[$i,$j]} < ${dp[$((i-1)),$((j-1))]} ? ${dp[$i,$j]} : ${dp[$((i-1)),$((j-1))]} ))
                dp[$i,$j]=$(( ${dp[$i,$j]} + 1 ))
            fi
        done
    done

    echo ${dp[$len1,$len2]}
}

# 获取显卡型号
GPU_MODEL=$(nvidia-smi --query-gpu=name --format=csv,noheader | sed -n '1p')

min_distance=999999
best_match=""

# 遍历字符串列表，找到最匹配的字符串
for model in "${!GPU_COMPUTE_MAP[@]}"; do
    distance=$(calculate_edit_distance "$model" "$GPU_MODEL")
    if ((distance <= min_distance)); then
        min_distance=$distance
        best_match=$model
    fi
done

GPU_COMPUTE=${GPU_COMPUTE_MAP[$best_match]}

export GPU_COMPUTE

echo "检测到显卡型号: $GPU_MODEL"
echo "匹配到显卡型号: $best_match"
echo "显卡算力: $GPU_COMPUTE"
