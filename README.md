# tgNetDisc
- 利用Telegram接口，无限容量，不限制文件格式，大文件会分片上传（速度挺慢），但不支持上传超大文件。
- 上传成功会生成HTML、Markdown、BBCode三种形式的外链，可以用来当做图床、文件下载url。
- 原作者地址：[https://github.com/csznet/tgState](https://github.com/csznet/tgState)

## 运行容器
- `TOKEN`是机器人token。
- `CHANNEL`可以是频道地址也可以是chatId（可以通过[@getidsbot](https://t.me/getidsbot)这个机器人获取）。如果是频道，需要将频道公开，并将机器人拉入频道，设置为管理员，频道地址格式如：`@yohannChannl`。如果是chatId，可以通过私聊机器人，引用文件（不支持3MB~10MB左右的视频文件，亲测会直接停止服务，10MB以上的分片文件，引用`fileAll.txt`是支持的）并回复`get`获取文件id（base64编码），通过`域名`+`/d/`+`文件id`可以直接下载该文件，如果是图片则可以直接查看。

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

