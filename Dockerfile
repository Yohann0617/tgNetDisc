# golang 基础镜像用于编译源码
FROM golang:latest AS build

# 拷贝源码进行编译
COPY . /root/tgNetDisc/
WORKDIR /root/tgNetDisc
RUN go build -o tgState main.go

# 使用官方的 Ubuntu 基础镜像
FROM ubuntu:latest

# 拷贝 ca-certificates 包及安装脚本
COPY repo /tmp/repo
COPY install-cert.sh /tmp/install-cert.sh

# 安装 ca-certificates 包
RUN chmod +x /tmp/install-cert.sh \
    && /tmp/install-cert.sh \
    && rm -rf /tmp/repo/ && rm -f /tmp/install-cert.sh

# 从基础镜像拷贝编译好的二进制文件
COPY --from=build /root/tgNetDisc/tgState /app/tgState

# 设置工作目录
WORKDIR /app

# 设置暴露的端口
EXPOSE 8088

# 设置容器启动时要执行的命令
CMD ["/app/tgState"]
