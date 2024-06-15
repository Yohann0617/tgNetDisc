[中文](https://github.com/Yohann0617/tgNetDisc/blob/master/README.md) | [EN](https://github.com/Yohann0617/tgNetDisc/blob/master/README_EN.md)
# tgNetDisc
>🤖利用Telegram接口（需要一台国外VPS），♾️️无限容量，不限制文件格式，不限制文件内容😏，占用很少的内存和磁盘空间📁，轻巧方便。
>文件都存储在Telegram☁️端，拥有良好的安全性🔒和持久性。
>大文件会分片上传（速度不快），但不支持上传超大文件。
>上传成功会生成HTML、Markdown、BBCode三种形式的外链🔗，可以用来当做图床、文件下载url。
>测试地址：☞[tgNetDisc](https://tgnetdisc.19990617.xyz)☜
>原作者地址：[https://github.com/csznet/tgState](https://github.com/csznet/tgState)，在此基础上进行了部分修改。

## Docker一键部署（推荐🏆）
- `TOKEN`是机器人token。
- `DOMAIN`是域名，可以不用配置
- `PASS`是密码，可以不用配置
- `CHANNEL`可以是频道地址也可以是chatId（可以通过 [@getidsbot](https://t.me/getidsbot) 这个机器人获取）。如果是频道，需要将频道公开，并将机器人拉入频道，设置为管理员，频道地址格式如：`@yohannChannl`。引用文件（分片文件引用`fileAll.txt`文件）并回复`get`，如果配置了`DOMAIN`域名参数，会返回完整url，反之则会返回文件id（base64编码），通过`域名`+`/d/`+`文件id`可以直接下载该文件，如果是图片则可以直接查看。

拉取个人镜像仓库镜像并启动容器：

```bash
docker run -d --network=host \
--name netdisc \
-e TOKEN=xxx \
-e CHANNEL=xxx \
-e MODE=pan \
-e PASS=yohann \
-e DOMAIN=https://hh.abc.com \
yohannfan/yohann-netdisc:latest
```

## 二进制可执行文件启动
参考原作者，本人暂未测试过。
```
 ./tgstate -token xxxx -channel @xxxx
```
其中的`xxxx`为bot token `@xxxx`为频道地址or个人id(个人ID只需要数字不需要@)

如果需要自定义端口，可以带上-port参数，如

```
-port 8888
```

如果不需要首页，只需要API和图片展示页面，则带上-index参数，如

```
./tgstate -token xxxx -channel @xxxx -port 8888 -index
```

如果需要限制密码访问，只需要带上-pass参数即可，如设置密码为csznet：

```
./tgstate -token xxxx -channel @xxxx -port 8888 -pass csznet
```

如果需要网盘模式运行，请带上-mode pan，如

```
./tgstate -token xxxx -channel @xxxx -port 8888 -mode pan
```

## 页面预览
![image](https://github.com/Yohann0617/tgNetDisc/assets/75626191/844a61aa-cfd2-40b3-b63c-bb9de0fb8438)
![image](https://github.com/Yohann0617/tgNetDisc/assets/75626191/227b83af-7c83-4b22-ba89-9f21606e44e9)

## Stargazers over time

[![Stargazers over time](https://starchart.cc/Yohann0617/tgNetDisc.svg)](https://starchart.cc/Yohann0617/tgNetDisc)
