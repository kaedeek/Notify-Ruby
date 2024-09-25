# main.rb
require_relative 'Notify'

# トークンを設定
token = "your token here"
# クラスのインスタンスを作成
message = LineNotify.new(token)

# メッセージを送信
begin
  message.SendMessage("Welcome to Kaedeek :)")
  puts "It's successful :)"
rescue => e
  puts "An error occurred: #{e.message}"
end
