package utils

import (
	"encoding/json"
	"io"
	"log"

	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api/v5"
	"yohann/tgNetDisc/conf"
)

func TgFileData(fileName string, fileData io.Reader) tgbotapi.FileReader {
	return tgbotapi.FileReader{
		Name:   fileName,
		Reader: fileData,
	}
}

func UpDocument(fileData tgbotapi.FileReader) string {
	bot, err := tgbotapi.NewBotAPI(conf.BotToken)
	if err != nil {
		log.Panic(err)
	}
	bot.Debug = true

	// Upload the file to Telegram
	params := tgbotapi.Params{
		"chat_id": conf.ChannelName, // Replace with the chat ID where you want to send the file
	}
	files := []tgbotapi.RequestFile{
		{
			Name: "document",
			Data: fileData,
		},
	}

	response, err := bot.UploadFiles("sendDocument", params, files)
	if err != nil {
		log.Panic(err)
	}
	var msg tgbotapi.Message
	err = json.Unmarshal([]byte(response.Result), &msg)
	var resp string
	if msg.Document != nil {
		resp = msg.Document.FileID
	} else if msg.Audio != nil {
		resp = msg.Audio.FileID
	} else if msg.Video != nil {
		resp = msg.Video.FileID
	}
	return resp
}

func GetDownloadUrl(fileID string) string {
	bot, err := tgbotapi.NewBotAPI(conf.BotToken)
	if err != nil {
		log.Panic(err)
	}

	// 使用 getFile 方法获取文件信息
	file, err := bot.GetFile(tgbotapi.FileConfig{FileID: fileID})
	if err != nil {
		log.Panic(err)
	}

	// 获取文件下载链接
	fileURL := file.Link(conf.BotToken)
	// log.Printf("File Download URL: %s", fileURL)
	return fileURL
}

func BotDo() {

	bot, err := tgbotapi.NewBotAPI(conf.BotToken)
	if err != nil {
		log.Println(err)
		return
	}

	bot.Debug = true

	log.Printf("Authorized on account %s", bot.Self.UserName)

	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60

	updatesChan := bot.GetUpdatesChan(u)

	for update := range updatesChan {
		// 私聊机器人
		if update.Message != nil {
			// 处理get
			if update.Message.Text == "get" {
				if update.Message.ReplyToMessage != nil {
					// video
					if update.Message.ReplyToMessage.Video != nil {
						if update.Message.ReplyToMessage.Video.FileID != "" {
							msg := tgbotapi.NewMessage(update.Message.Chat.ID, update.Message.ReplyToMessage.Video.FileID)
							_, err := bot.Send(msg)
							if err != nil {
								log.Println(err)
							}
						}
					}
					// 其他文件
					if update.Message.ReplyToMessage.Document != nil {
						if update.Message.ReplyToMessage.Document.FileID != "" {
							msg := tgbotapi.NewMessage(update.Message.Chat.ID, update.Message.ReplyToMessage.Document.FileID)
							msg.ReplyToMessageID = update.Message.MessageID
							_, err := bot.Send(msg)
							if err != nil {
								log.Println(err)
							}
						}
					}
				}
			}
		}
		// 频道
		if update.ChannelPost != nil {
			// 处理get
			if update.ChannelPost.Text == "get" {
				if update.ChannelPost.ReplyToMessage != nil {
					// video
					if update.ChannelPost.ReplyToMessage.Video != nil {
						if update.ChannelPost.ReplyToMessage.Video.FileID != "" {
							msg := tgbotapi.NewMessage(update.ChannelPost.Chat.ID, update.ChannelPost.ReplyToMessage.Video.FileID)
							_, err := bot.Send(msg)
							if err != nil {
								log.Println(err)
							}
						}
					}
					// 其他文件
					if update.ChannelPost.ReplyToMessage.Document != nil {
						if update.ChannelPost.ReplyToMessage.Document.FileID != "" {
							msg := tgbotapi.NewMessage(update.ChannelPost.Chat.ID, update.ChannelPost.ReplyToMessage.Document.FileID)
							_, err := bot.Send(msg)
							if err != nil {
								log.Println(err)
							}
						}
					}
				}
			}
		}
	}
}
