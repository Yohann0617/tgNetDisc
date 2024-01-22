# 使用官方的 Ubuntu 基础镜像
FROM ubuntu:latest AS build

# 安装 ca-certificates 包，用于更新根证书
RUN apt-get update \
    && mkdir -p /root/repo && chmod a+rX /root/repo \
    && apt-get update && apt-get download -o Dir::Cache::archives=/root/repo openssl \
    && apt-get update && apt-get download -o Dir::Cache::archives=/root/repo ca-certificates \
    && apt-get install -y ca-certificates golang \
    && apt-get clean

COPY . /root/tgNetDisc/

WORKDIR /root/tgNetDisc

RUN go build -o tgState main.go \
    && mkdir -p /app/ \
    && cp tgState /app/tgState

FROM ubuntu:latest

COPY --from=build /root/repo /tmp/repo

RUN dpkg -i /tmp/repo/*.deb && apt-get install -f \
    && rm -rf /tmp/repo/ && apt-get clean

COPY --from=build /app/tgState /app/tgState

# 设置工作目录
WORKDIR /app

# 设置暴露的端口
EXPOSE 8088

# 设置容器启动时要执行的命令
CMD ["/app/tgState"]