# golang 基础镜像用于编译源码
FROM golang:alpine AS build

# 拷贝源码进行编译
COPY . /root/tgNetDisc/
WORKDIR /root/tgNetDisc
RUN go build -o tgState main.go

# 使用官方的 alpine 基础镜像
FROM alpine:latest

# 安装 ca-certificates 包
RUN apk add --no-cache ca-certificates openssl tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del

# 从基础镜像拷贝编译好的二进制文件
COPY --from=build /root/tgNetDisc/tgState /app/tgState

# 设置工作目录
WORKDIR /app

# 设置暴露的端口
EXPOSE 8088

# 设置容器启动时要执行的命令
CMD ["/app/tgState"]
