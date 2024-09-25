# Line Notify Ruby

Line Notifyの送信などの奴をRubyで作ってみた((殴
まだまだ、機能追加するからお楽しみに

## Function
- SendMessage
- Check

## Token
LINE Notifyのトークン取得方法

[ここ](https://notify-bot.line.me/ja/)からアカウントを登録してトークンを取得

発行されたトークンをコピーして"main.rb"を開き以下のようしてね

```
token = "your token here"
```

## Usage

#### 送信
```
message.SendMessage("Welcome to Kaedeek :)")
```

## Author

* Kaede