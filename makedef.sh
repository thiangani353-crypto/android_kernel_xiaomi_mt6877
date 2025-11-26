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

function tanya_hapus_out() {
    if [ -d "out" ]; then
        echo -e "${yellow}Folder 'out' terdeteksi. Apakah ingin menghapusnya? (y/n)${white}"
        read -r jawab
        if [[ "$jawab" == "y" || "$jawab" == "Y" ]]; then
            echo -e "${red}Menghapus folder out...${white}"
            rm -rf out
        else
            echo -e "${green}Tidak menghapus folder out.${white}"
        fi
    else
        echo -e "${green}Folder 'out' tidak ada, lanjut proses...${white}"
    fi
}

function make_defconfig() {
    echo -e "\n"
    echo -e "$red << make config >> \n$white"
    echo -e "\n"
    # generate default config
    make ARCH=arm64 O=out ruby_defconfig
    echo -e "\n"
    echo -e "$red << make config succes >> \n$white"
    echo -e "\n"
}



# execute
clean
cek_clang
tanya_hapus_out
make_defconfig