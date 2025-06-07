# Alist-Proxy Render 部署指南

## 项目概述

alist-proxy 是一个为 alist 文件管理系统提供代理下载服务的 Go 应用程序。本指南将帮助您将此项目部署到 Render 云平台。

## 部署前准备

### 1. 环境变量配置

在 Render 控制台中需要配置以下环境变量：

- `ALIST_ADDRESS`: alist 服务器地址 (例如: https://your-alist-server.com)
- `ALIST_TOKEN`: alist 服务器的访问令牌
- `PORT`: 服务端口 (Render 会自动设置，通常不需要手动配置)

### 2. 项目要求

- Go 1.19 或更高版本
- 有效的 alist 服务器实例
- GitHub 仓库 (用于自动部署)

### 3. 依赖管理说明

- 项目不包含 `go.sum` 文件，这是故意的
- Render 在构建时会自动运行 `go mod tidy` 来下载依赖并生成 `go.sum`
- 这确保了依赖的版本兼容性和安全性

## Render 部署步骤

### 方法一：使用 render.yaml 自动部署

1. **推送代码到 GitHub**
   ```bash
   git add .
   git commit -m "Add Render deployment configuration"
   git push origin main
   ```

2. **在 Render 控制台创建服务**
   - 访问 [Render Dashboard](https://dashboard.render.com/)
   - 点击 "New +" → "Web Service"
   - 连接您的 GitHub 仓库
   - 选择 alist-proxy 仓库

3. **Render 会自动检测 render.yaml 配置文件**
   - 服务类型: Web Service
   - 环境: Go
   - 构建命令: `go mod tidy && go build -o bin/alist-proxy -ldflags="-w -s" .`
   - 启动命令: `./bin/alist-proxy`
   - 注意: `go mod tidy` 会自动下载依赖并生成 go.sum 文件

4. **配置环境变量**
   - 在服务设置中添加环境变量：
     - `ALIST_ADDRESS`: 您的 alist 服务器地址
     - `ALIST_TOKEN`: 您的 alist 访问令牌

5. **部署服务**
   - 点击 "Create Web Service"
   - Render 将自动构建和部署您的应用

### 方法二：手动配置部署

如果您不想使用 render.yaml，可以手动配置：

1. **创建新的 Web Service**
   - 选择 "Build and deploy from a Git repository"
   - 连接您的 GitHub 仓库

2. **配置构建设置**
   - Name: `alist-proxy`
   - Environment: `Go`
   - Build Command: `go mod tidy && go build -o bin/alist-proxy -ldflags="-w -s" .`
   - Start Command: `./bin/alist-proxy`

3. **高级设置**
   - Health Check Path: `/health`
   - Auto-Deploy: Yes

4. **环境变量**
   - 添加必要的环境变量 (见上文)

## 验证部署

### 1. 检查服务状态
- 在 Render 控制台查看部署日志
- 确认服务状态为 "Live"

### 2. 测试健康检查
访问您的服务 URL + `/health`，应该返回：
```json
{
  "status": "healthy",
  "service": "alist-proxy"
}
```

### 3. 测试代理功能
使用带有有效签名的请求测试代理下载功能。

## 故障排除

### 常见问题

1. **构建失败**
   - 检查 Go 版本兼容性
   - 确认 go.mod 文件正确

2. **启动失败**
   - 检查环境变量是否正确设置
   - 查看应用日志获取详细错误信息

3. **代理功能不工作**
   - 验证 ALIST_ADDRESS 和 ALIST_TOKEN 是否正确
   - 确认 alist 服务器可访问

### 日志查看

在 Render 控制台的 "Logs" 标签页可以查看实时日志：
- 构建日志
- 应用运行日志
- 错误信息

## 成本说明

- Render 免费计划包含：
  - 750 小时/月的运行时间
  - 自动 SSL 证书
  - 自定义域名支持

## 更新部署

当您推送新代码到 GitHub 主分支时，Render 会自动重新部署您的应用（如果启用了 Auto-Deploy）。

## 安全建议

1. 使用环境变量存储敏感信息（如 token）
2. 定期更新依赖项
3. 监控应用日志以发现异常活动

## 支持

如果遇到问题，可以：
1. 查看 Render 官方文档
2. 检查项目的 GitHub Issues
3. 联系 Render 支持团队
