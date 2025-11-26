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
CLANG_DIR="${WORK_DIR}/myclang"
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


function clean() {
    echo -e "\n"
    echo -e "$red << cleaning up >> \n$white"
    echo -e "\n"
    # rm -rf out
}

function cek_clang() {
    echo -e "${yellow}== Checking Clang Version ==${white}"
    clang --version
}



function cek() {
    echo -e "\n"
    echo -e "$yellow << building kernel modules only >> \n$white"
    echo -e "\n"

    # pastikan config sudah ada
    if [ ! -f "${OUT_DIR}/.config" ]; then
        echo -e "${red}ERROR: .config tidak ditemukan!${white}"
        echo -e "${yellow}Jalankan dulu: make ARCH=arm64 O=out ruby_defconfig${white}"
        exit 1
    fi
}

function build_kernel() {
    echo -e "\n"
    echo -e "$yellow << building kernel >> \n$white"
    echo -e "\n"

    make -j"$(nproc --all)" ARCH=arm64 \
         O=out \
         CC=clang \
         CLANG_TRIPLE=aarch64-linux-gnu- \
         CROSS_COMPILE=aarch64-linux-gnu- \
         CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
         CROSS_COMPILE_COMPAT=arm-linux-gnueabi-

    if [ -e "$KERN_IMG" ] || [ -e "$KERN_IMG2" ]; then
        echo -e "\n$green << compile kernel success! >> \n$white\n"
    else
        echo -e "\n$red << compile kernel failed! >> \n$white\n"
    fi
}

# execute
clean
cek_clang
cek
build_kernel