- [Docker构建个人网盘镜像](#Docker构建个人网盘镜像)
    - [1.创建Dockerfile](#创建Dockerfile)
    - [2.构建镜像](#构建镜像)
    - [3.运行容器](#运行容器)

# Docker构建个人网盘镜像
- 利用Telegram接口，无限容量，不限制文件格式，大文件会分片上传（速度挺慢），但不支持上传超大文件。
- 上传成功会生成HTML、Markdown、BBCode三种形式的外链，可以用来当做图床、文件下载url。
- 原作者地址：[https://github.com/csznet/tgState](https://github.com/csznet/tgState)

## 创建Dockerfile

所需本地文件都在`telegram_netdisc`目录下

```bash
cat << EOF > $PWD/Dockerfile
# 使用官方的 Ubuntu 基础镜像
FROM ubuntu:latest

# 将本地的 .deb 文件复制到容器中
COPY openssl.deb /tmp/openssl.deb
COPY ca-certificates.deb /tmp/ca-certificates.deb

# 安装容器内的 .deb 文件
RUN dpkg -i /tmp/openssl.deb && apt-get install -f
RUN dpkg -i /tmp/ca-certificates.deb && apt-get install -f

# 将编译好的二进制文件复制到容器中
COPY tgstate /app/tgState

# 设置工作目录
WORKDIR /app

# 设置暴露的端口
EXPOSE 8088

# 设置容器启动时要执行的命令
CMD ["/app/tgState"]
EOF
```

## 构建镜像

```bash
# 构建镜像
docker build -t yohann-netdisc .

# 以下操作可省略。。。
# 登录个人docker
docker login
# 打标签
docker tag yohann-netdisc:latest yohannfan/yohann-netdisc:1.0
# 上传到个人docker镜像仓库
docker push yohannfan/yohann-netdisc:1.0
```

## 运行容器
- `TOKEN`是机器人token。
- `CHANNEL`可以是频道地址也可以是chatId（可以通过[@getidsbot](https://t.me/getidsbot)这个机器人获取）。如果是频道，需要将频道公开，并将机器人拉入频道，设置为管理员，频道地址格式如：`@yohannChannl`。如果是chatId，可以通过私聊机器人，引用文件（不支持3MB~10MB左右的视频文件，亲测会直接停止服务，10MB以上的分片文件，引用`fileAll.txt`是支持的）并回复`get`获取文件id（base64编码），通过`域名`+`/d/`+`文件id`可以直接下载该文件，如果是图片则可以直接查看。

本地镜像启动：

```bash
docker run -d -p 8088:8088 \
--network=host \
--name netdisc \
-e TOKEN=xxx \
-e CHANNEL=xxx \
-e MODE=pan \
yohann-netdisc:latest
```

个人镜像仓库镜像启动：

```bash
docker run -d -p 8088:8088 \
--network=host \
--name netdisc \
-e TOKEN=xxx \
-e CHANNEL=xxx \
-e MODE=pan \
yohannfan/yohann-netdisc:1.0
```

