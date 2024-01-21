# 使用官方的 Ubuntu 基础镜像
FROM ubuntu:latest

# 安装 ca-certificates 包，用于更新根证书
RUN apt-get update \
    && apt-get install -y ca-certificates golang \
    && apt-get clean

# 将本地的 .deb 文件复制到容器中
#COPY repo/openssl.deb /tmp/openssl.deb
#COPY repo/ca-certificates.deb /tmp/ca-certificates.deb
COPY . /root/tgNetDisc/

# 安装容器内的 .deb 文件
#RUN dpkg -i /root/tgNetDisc/repo/openssl.deb && apt-get install -f \
#    && dpkg -i /root/tgNetDisc/repo/ca-certificates.deb && apt-get install -f \
#    && rm -f /root/tgNetDisc/repo/openssl.deb && rm -f /root/tgNetDisc/repo/ca-certificates.deb

WORKDIR /root/tgNetDisc

RUN go build -o tgState main.go \
    && mkdir -p /app/ \
    && cp tgState /app/tgState \
    && rm -rf /root/tgNetDisc

# 将编译好的二进制文件复制到容器中
#COPY /root/tgNetDisc/tgState /app/tgState

# 设置工作目录
WORKDIR /app

# 设置暴露的端口
EXPOSE 8088

# 设置容器启动时要执行的命令
CMD ["/app/tgState"]