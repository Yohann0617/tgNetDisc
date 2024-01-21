# 使用官方的 Ubuntu 基础镜像
FROM ubuntu:latest AS build

# 安装 ca-certificates 包，用于更新根证书
RUN apt-get update \
    && apt-get install -y golang \
    && apt-get clean

COPY . /root/tgNetDisc/

WORKDIR /root/tgNetDisc

RUN go build -o tgState main.go \
    && mkdir -p /app/ \
    && cp tgState /app/tgState \
    && rm -rf /root/tgNetDisc

FROM ubuntu:latest
RUN apt-get update \
    && apt-get install -y ca-certificates \
    && apt-get clean
COPY --from=build /app/tgState /app/tgState

# 设置工作目录
WORKDIR /app

# 设置暴露的端口
EXPOSE 8088

# 设置容器启动时要执行的命令
CMD ["/app/tgState"]