#!/bin/bash

# 检查是否以root权限运行
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：此脚本需要以root权限运行，请使用sudo执行"
    exit 1
fi

if ! grep -q "Ubuntu 22.04" /etc/os-release; then
    OS_NAME=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | sed 's/"//g')
    echo "此脚本专为 Ubuntu 22.04 设计，检测到不兼容的操作系统: $OS_NAME"
    exit 1
fi

echo "下载所有的依赖包..."



sudo apt-get download -o Dir::Cache="./" -o Dir::Cache::archives="./" pkg-config python3-pip python3-libvirt python3-jmespath qemu-system-x86 libvirt-daemon-system libvirt-dev virtinst libvirt-clients bridge-utils


echo "所有软件包下载完成！"
