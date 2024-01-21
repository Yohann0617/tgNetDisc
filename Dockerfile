# 使用官方的 Ubuntu 基础镜像
FROM ubuntu:latest AS build

# 安装 ca-certificates 包，用于更新根证书
RUN apt-get update \
    && apt-get install -y ca-certificates golang \
    && apt-get clean

COPY . /root/tgNetDisc/

WORKDIR /root/tgNetDisc

RUN go build -o tgState main.go \
    && mkdir -p /app/ \
    && cp tgState /app/tgState \
    && rm -rf /root/tgNetDisc

FROM ubuntu:latest

# 将本地的 .deb 文件复制到容器中
COPY repo/openssl.deb /tmp/openssl.deb
COPY repo/ca-certificates.deb /tmp/ca-certificates.deb

# 安装容器内的 .deb 文件
RUN dpkg -i /tmp/openssl.deb && apt-get install -f \
    && dpkg -i /tmp/ca-certificates.deb && apt-get install -f \
    && rm -f /tmp/openssl.deb && rm -f /tmp/ca-certificates.deb \
    && apt-get clean

COPY --from=build /app/tgState /app/tgState

# 设置工作目录
WORKDIR /app

# 设置暴露的端口
EXPOSE 8088

# 设置容器启动时要执行的命令
CMD ["/app/tgState"]