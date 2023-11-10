[中文](https://github.com/Yohann0617/tgNetDisc/blob/master/README.md) | [EN](https://github.com/Yohann0617/tgNetDisc/blob/master/README_EN.md)
# tgNetDisc
- Using the Telegram interface, unlimited capacity, no limit on file formats, large files will be uploaded in parts (the speed is quite slow), but it does not support uploading super large files.
- If the upload is successful, three forms of external links will be generated: HTML, Markdown, and BB Code, which can be used as image beds and file download URLs.
- Test address:[tgNetDisc](https://yo.yohann.buzz/netdisc)
- Original Author's Address:[https://github.com/csznet/tgState](https://github.com/csznet/tgState) On this basis, some modifications are made.

## Docker One-click deployment (recommended 🏆)
- `TOKEN`is a bot token.
- `CHANNEL`It can be the channel address or the chatId (which can be obtained through the bot [@getidsbot](https://t.me/getidsbot)). If it is a channel, you need to make the channel public, pull the bot into the channel, set it as an administrator, and the channel address format is as follows: `@yohannChannl`. If it is chatId, you can get the file id (base64 encoding) through the private chat bot, reference file (video files around 3MB~10MB are not supported, the pro-test will directly stop the service, fragmented files of more than 10MB, reference `fileAll.txt` is supported) and reply `get` to get the file id (base64 encoding), through `domain name`+`/d`+`file id` can directly download the file, if it is a picture, you can view it directly.

Pull the personal registry image and start the container:

```bash
docker run -d --network=host \
--name netdisc \
-e TOKEN=xxx \
-e CHANNEL=xxx \
-e MODE=pan \
yohannfan/yohann-netdisc:1.0
```

## The binary executable starts
```
./tgState -token xxxx -channel @xxxx
```

Replace xxxx with your bot token and @xxxx with the channel address or personal ID (for personal IDs, only use numbers without @).

To customize the port, use the -port parameter, for example:

```
-port 8888
```

If you don't need the homepage and only want the API and image display page, use the -index parameter, like this:

```
./tgState -token xxxx -channel @xxxx -port 8888 -index
```

To enable password protection, use the -pass parameter, for example, to set the password as csznet:

```
./tgState -token xxxx -channel @xxxx -port 8888 -pass csznet
```

For cloud storage mode, use the -mode pan parameter, like this:

```
./tgState -token xxxx -channel @xxxx -port 8888 -mode pan
```



## Page preview
![Alt Text](https://yo.yohann.buzz/d/BQACAgUAAxkDAANDZUxa0bRG9KCFuKdO8GfMtXf4AeEAAuEKAAJg12FWkS1Xmkrd37QzBA)

