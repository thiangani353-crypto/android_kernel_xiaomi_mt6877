#!/bin/bash
# Copyright cc 2023 sirnewbies

# setup color
red='\033[0;31m'
green='\e[0;32m'
white='\033[0m'
yellow='\033[0;33m'

install_1() {
    echo -e "${green}Installing dependencies...${white}"
    sudo apt-get update
    sudo apt-get install -y tmate fish zip wget gcc g++ \
            gcc-aarch64-linux-gnu gcc-arm-linux-gnueabihf
    echo -e "${red}Dependencies installed successfully.${white}"
}

install_2() {
    echo -e "${green}Installing dependencies2...${white}"
    sudo apt install -y nano bc bison ca-certificates curl flex gcc git libc6-dev libssl-dev openssl python-is-python3 ssh wget zip zstd sudo make clang gcc-arm-linux-gnueabi software-properties-common build-essential libarchive-tools gcc-aarch64-linux-gnu
    echo -e "${red}Dependencies2 installed successfully.${white}"
}

download_clang(){
    echo -e "${green}Downloading and setting up Clang...${white}"
    wget https://github.com/Gonon-Kernel/gonon-clang/releases/download/14.0.6-20231101-release/GononClang-14.0.6-20231101.tar.xz
    mkdir myclang
    tar -xvf GononClang-14.0.6-20231101.tar.xz -C myclang
    echo -e "${red}Clang setup completed.${white}"    
}

install_1
install_2
download_clang  
echo -e "${yellow}All installations completed successfully!${white}"
