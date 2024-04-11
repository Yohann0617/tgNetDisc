package main

import (
	"flag"
	"fmt"
	"net"
	"net/http"

	"os"

	"yohann/tgNetDisc/conf"
	"yohann/tgNetDisc/control"
	"yohann/tgNetDisc/utils"
)

var webPort string
var OptApi = true

func main() {
	//判断是否设置参数
	if conf.BotToken == "" || conf.ChannelName == "" {
		fmt.Println("请先设置Bot Token和对象")
		return
	}
	go utils.BotDo()
	web()
}

func web() {
	http.HandleFunc(conf.FileRoute, control.D)
	if OptApi {
		if conf.Pass != "" && conf.Pass != "none" {
			http.HandleFunc("/pwd", control.Pwd)
		}
		http.HandleFunc("/api", control.Middleware(control.UploadImageAPI))
		http.HandleFunc("/", control.Middleware(control.Index))
	}

	if listener, err := net.Listen("tcp", ":"+webPort); err != nil {
		fmt.Printf("端口 %s 已被占用\n", webPort)
	} else {
		defer listener.Close()
		fmt.Printf("启动Web服务器，监听端口 %s\n", webPort)
		if err := http.Serve(listener, nil); err != nil {
			fmt.Println(err)
		}
	}
}

func init() {
	flag.StringVar(&webPort, "port", "8088", "Web Port")
	flag.StringVar(&conf.BotToken, "token", os.Getenv("TOKEN"), "Bot Token")
	flag.StringVar(&conf.ChannelName, "channel", os.Getenv("CHANNEL"), "Channel Name")
	flag.StringVar(&conf.Pass, "pass", os.Getenv("PASS"), "Visit Password")
	flag.StringVar(&conf.Mode, "mode", os.Getenv("MODE"), "Run mode")
	flag.StringVar(&conf.Domain, "domain", os.Getenv("DOMAIN"), "domain name")
	flag.Parse()
	if conf.Mode == "m" {
		OptApi = false
	}
	if conf.Mode != "pan" && conf.Mode != "m" {
		conf.Mode = "pan"
	}
}
