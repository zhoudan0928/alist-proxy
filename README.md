# alist-proxy

一个为 alist 文件管理系统提供代理下载服务的 Go 应用程序。

## 支持的部署方式

- [x] cloudflare workers
- [x] golang
- [x] Render 云平台
- [x] Docker

## 快速开始

### 本地运行

```bash
# 克隆项目
git clone https://github.com/Xhofe/alist-proxy.git
cd alist-proxy

# 构建项目
go build -o bin/alist-proxy .

# 运行 (需要设置环境变量或使用命令行参数)
export ALIST_ADDRESS="https://your-alist-server.com"
export ALIST_TOKEN="your-alist-token"
./bin/alist-proxy
```

### 环境变量

- `ALIST_ADDRESS`: alist 服务器地址
- `ALIST_TOKEN`: alist 服务器访问令牌
- `PORT`: 服务端口 (默认: 5243)

### 命令行参数

```bash
./alist-proxy -address "https://your-alist-server.com" -token "your-token" -port 5243
```

## 部署到 Render

详细的 Render 部署指南请参考 [RENDER_DEPLOYMENT.md](./RENDER_DEPLOYMENT.md)

### 一键部署

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

## API 端点

- `GET /health` - 健康检查
- `GET /{path}?sign={signature}` - 代理下载文件

## Docker 部署

```bash
# 构建镜像
docker build -t alist-proxy .

# 运行容器
docker run -p 5243:5243 \
  -e ALIST_ADDRESS="https://your-alist-server.com" \
  -e ALIST_TOKEN="your-token" \
  alist-proxy
```
