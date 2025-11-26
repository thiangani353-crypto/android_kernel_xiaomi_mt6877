#!/bin/bash
# Copyright cc 2023 sirnewbies

# setup color
red='\033[0;31m'
green='\e[0;32m'
white='\033[0m'
yellow='\033[0;33m'

WORK_DIR=$(pwd)
OUT_DIR="${WORK_DIR}/out"
KERN_IMG="${OUT_DIR}/arch/arm64/boot/Image-gz.dtb"
KERN_IMG2="${OUT_DIR}/arch/arm64/boot/Image.gz"

# ==== PATH CLANG ====
CLANG_DIR="${WORK_DIR}/mylcang"
export PATH="$CLANG_DIR/bin:$PATH"

# LLVM tools
export CC=clang
export LD=ld.lld
export AR=llvm-ar
export NM=llvm-nm
export AS=llvm-as
export OBJCOPY=llvm-objcopy
export OBJDUMP=llvm-objdump
export STRIP=llvm-strip



function make_defconfig() {
    echo -e "\n"
    echo -e "$red << make make old confg >> \n$white"
    echo -e "\n"
    make ARCH=arm64 O=out olddefconfig
    echo -e "\n"
    echo -e "$red << make make old confg succes >> \n$white"
    echo -e "\n"
}


make_defconfig
