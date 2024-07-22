[中文](https://github.com/Yohann0617/tgNetDisc/blob/master/README.md) | [EN](https://github.com/Yohann0617/tgNetDisc/blob/master/README_EN.md)
# tgNetDisc
>🤖Use the Telegram interface (requires a VPS that can connect to the Internet), ♾️️ unlimited capacity, no limits on file formats, no limits on file content😏, takes up very little memory and disk space📁, lightweight and convenient.
>Files are stored on Telegram☁️ side, with good security🔒 and durability.
>Large files will be uploaded in parts (not fast), but uploading very large files is not supported.
>Successful upload will generate external links in the form of HTML, Markdown, and BBCode🔗, which can be used as image beds and file download URLs.
>Test address:☞[tgNetDisc](https://tgnetdisc.yohann.us.kg)☜
>Original Author's Address:[https://github.com/csznet/tgState](https://github.com/csznet/tgState), On this basis, some modifications are made.

## Docker One-click deployment (recommended 🏆)
- `TOKEN` is the robot token.
- `DOMAIN` is the domain name and does not need to be configured.
- `PASS` is the password and does not need to be configured.
- `CHANNEL` can be the channel address or chatId (can be obtained through the robot [@getidsbot](https://t.me/getidsbot)). If it is a channel, you need to make the channel public, pull the robot into the channel, and set it as an administrator. The channel address format is such as: `@yohannChannl`. Reference the file (for fragmented files, reference the `fileAll.txt` file) and reply to `get`. If the `DOMAIN` domain name parameter is configured, the complete URL will be returned. Otherwise, the file id (base64 encoding) will be returned. Pass `Domain name`+`/d/`+`File id` can directly download the file, and if it is a picture, it can be viewed directly.

Pull the personal registry image and start the container:

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
![image](https://github.com/Yohann0617/tgNetDisc/assets/75626191/729b766c-0cb0-49d3-bca0-130a98867368)
![image](https://github.com/Yohann0617/tgNetDisc/assets/75626191/227b83af-7c83-4b22-ba89-9f21606e44e9)

## API request example
```bash
curl -X POST -F "image=@/root/test/tgNetDisc;type=application/octet-stream" https://hh.abc.com/api
```
If a password is set:
```bash
curl -X POST -F "image=@/root/test/tgNetDisc;type=application/octet-stream" -b "p=YOURPASSWORD" https://hh.abc.com/api
```

## Stargazers over time

[![Stargazers over time](https://starchart.cc/Yohann0617/tgNetDisc.svg)](https://starchart.cc/Yohann0617/tgNetDisc)

