#!/bin/bash

# 镜像仓库基础路径
BASE_REPO="g-ubjg5602-docker.pkg.coding.net/iscas-system/containers"

# 镜像名称列表
IMAGES=(
    "univirt-ubuntu22-virtmonitor"
    "univirt-ubuntu22-libvirtwatcher"
    "univirt-ubuntu22-virtlet"
    "univirt-ubuntu22-virtctl"
)

# 默认版本号
DEFAULT_TAG="v1.0.11.lab"

# 获取用户指定的版本号，如未指定则使用默认值
TAG="${1:-$DEFAULT_TAG}"

echo "镜像将保存到当前目录"

# 拉取并保存每个镜像
for image in "${IMAGES[@]}"; do
    full_image_name="$BASE_REPO/$image:$TAG"
    save_file="${image}_${TAG}.tar"

    echo "----------------------------------------"
    echo "正在拉取镜像: $full_image_name"

    # 拉取镜像
    if docker pull "$full_image_name"; then
        echo "拉取成功，正在保存镜像到 $save_file"
        # 保存镜像到本地文件
        if docker save -o "$save_file" "$full_image_name"; then
            echo "镜像保存成功"
        else
            echo "保存镜像 $image 失败"
        fi
    else
        echo "拉取镜像 $image 失败"
    fi
done

echo "----------------------------------------"
echo "操作完成。所有成功拉取的镜像已保存到当前目录"
