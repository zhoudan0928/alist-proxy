FROM alpine:edge as builder
LABEL stage=go-builder
WORKDIR /app/

# 安装构建依赖
RUN apk add --no-cache bash curl gcc git go musl-dev

# 复制 go.mod 文件
COPY go.mod ./

# 复制源代码
COPY . .

# 下载依赖并构建应用
RUN go mod tidy && go build -o /app/bin/alist-proxy -ldflags="-w -s" .

FROM alpine:edge
LABEL MAINTAINER="i@nn.ci"
WORKDIR /app/
COPY --from=builder /app/bin/alist-proxy ./
EXPOSE 5243
CMD [ "./alist-proxy" ]
