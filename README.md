[中文](https://github.com/Yohann0617/tgNetDisc/blob/master/README.md) | [EN](https://github.com/Yohann0617/tgNetDisc/blob/master/README_EN.md)
# tgNetDisc
- 利用Telegram接口，无限容量，不限制文件格式，大文件会分片上传（速度不快），但不支持上传超大文件。
- 上传成功会生成HTML、Markdown、BBCode三种形式的外链，可以用来当做图床、文件下载url。
- 测试地址：[tgNetDisc](https://yo.yohann.buzz/netdisc)
- 原作者地址：[https://github.com/csznet/tgState](https://github.com/csznet/tgState)

## Docker一键部署（推荐🏆）
- `TOKEN`是机器人token。
- `CHANNEL`可以是频道地址也可以是chatId（可以通过 [@getidsbot](https://t.me/getidsbot) 这个机器人获取）。如果是频道，需要将频道公开，并将机器人拉入频道，设置为管理员，频道地址格式如：`@yohannChannl`。如果是chatId，可以通过私聊机器人，引用文件（不支持3MB~10MB左右的视频文件，亲测会直接停止服务，10MB以上的分片文件，引用`fileAll.txt`是支持的）并回复`get`获取文件id（base64编码），通过`域名`+`/d/`+`文件id`可以直接下载该文件，如果是图片则可以直接查看。

拉取个人镜像仓库镜像并启动容器：

```bash
docker run -d --network=host \
--name netdisc \
-e TOKEN=xxx \
-e CHANNEL=xxx \
-e MODE=pan \
yohannfan/yohann-netdisc:1.0
```

## 二进制可执行文件启动
参考原作者
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
![Alt Text](https://yo.yohann.buzz/d/BQACAgUAAxkDAANDZUxa0bRG9KCFuKdO8GfMtXf4AeEAAuEKAAJg12FWkS1Xmkrd37QzBA)

