#!/bin/bash
# # x86
# /usr/bin/g++ hello-cublas.cxx \
#        -I /usr/local/cuda-11.4/targets/x86_64-linux/include \
#        -L /usr/local/cuda-11.4/targets/x86_64-linux/lib \
#        -lcudart -lcublas

# # cross-platform for aarch64 using nvidia cross-platform container
# # https://catalog.ngc.nvidia.com/orgs/nvidia/containers/jetpack-linux-aarch64-crosscompile-x86
# /l4t/toolchain/bin/aarch64-buildroot-linux-gnu-g++ hello-cublas.cxx \
#        -I /l4t/targetfs/usr/local/cuda-11.4/targets/aarch64-linux/include \
#        -L /l4t/targetfs/usr/local/cuda-11.4/targets/aarch64-linux/lib \
#        -lcudart -lcublas
