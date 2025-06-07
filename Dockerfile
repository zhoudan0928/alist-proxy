FROM alpine:edge as builder
LABEL stage=go-builder
WORKDIR /app/

# 安装构建依赖
RUN apk add --no-cache bash curl gcc git go musl-dev

# 复制 go.mod 和 go.sum 文件
COPY go.mod go.sum ./

# 下载依赖
RUN go mod download

# 复制源代码
COPY . .

# 构建应用
RUN go build -o /app/bin/alist-proxy -ldflags="-w -s" .

FROM alpine:edge
LABEL MAINTAINER="i@nn.ci"
WORKDIR /app/
COPY --from=builder /app/bin/alist-proxy ./
EXPOSE 5243
CMD [ "./alist-proxy" ]
