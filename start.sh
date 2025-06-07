#!/bin/bash

# 构建应用
echo "Building alist-proxy..."
go build -o bin/alist-proxy -ldflags="-w -s" .

# 检查构建是否成功
if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

echo "Build successful!"

# 启动应用
echo "Starting alist-proxy..."
./bin/alist-proxy
