#!/bin/bash
# # x86
# /usr/local/cuda-11.4/bin/nvcc -ccbin \
# /usr/bin/g++ -std=c++11 \
# --gpu-architecture=compute_87 \
# --gpu-code=sm_87,compute_87 \
# hello.cu

# cross-platform for aarch64 using nvidia cross-platform container
# https://catalog.ngc.nvidia.com/orgs/nvidia/containers/jetpack-linux-aarch64-crosscompile-x86
#/l4t/targetfs/usr/local/cuda-11.4/bin/nvcc -ccbin \
/usr/local/cuda-11.4/bin/nvcc -ccbin \
    /l4t/toolchain/bin/aarch64-buildroot-linux-gnu-g++ -std=c++11 \
    --gpu-architecture=compute_87 \
    --gpu-code=sm_87,compute_87 \
    hello.cu



