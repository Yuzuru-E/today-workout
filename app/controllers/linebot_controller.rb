class LinebotController < ApplicationController
  class LinebotController < ApplicationController
    require 'line/bot'  # gem 'line-bot-api'
    require 'open-uri'
    require 'kconv'
    require 'rexml/document'
  
    # callbackアクションのCSRFトークン認証を無効
    protect_from_forgery :except => [:callback]
  
    def callback
      body = request.body.read
      signature = request.env['HTTP_X_LINE_SIGNATURE']
      unless client.validate_signature(body, signature)
        error 400 do 'Bad Request' end
      end
      events = client.parse_events_from(body)
      events.each { |event|
        case event
          # メッセージが送信された場合の対応（機能①）
        when Line::Bot::Event::Message
          case event.type
            # ユーザーからテキスト形式のメッセージが送られて来た場合
          when Line::Bot::Event::MessageType::Text
            # event.message['text']：ユーザーから送られたメッセージ
            input = event.message['text']
            line_id = event['source']['userId']
            # ①筋トレを行う曜日の指定
            # 曜日が含まれている場合の処理
            case input
              user = User.find_by(line_id: line_id)
            # when input.include?("月"||"火"||"水"||"木"||"金"||"土"||"日") && input.include?(" ")
            #     @schedules = input.split(' ')
            #     @schedules.each do |schedule|
            #       case schedule
            when "月"
              user.update(monday: 1)
              push = 
              "筋トレを行う曜日は#{input}だなッッ\n他の曜日にも筋トレする場合は改めて曜日を入力してくれッッ\n一通り曜日の入力が終わったら、筋トレを行う時間を1時間単位で入力してくれッッ\n入力例:18\n0~23の範囲で入力してくれッッ"
            when "火"
              user.update(tuesday: 1)
              push = 
              "筋トレを行う曜日は#{input}だなッッ\n他の曜日にも筋トレする場合は改めて曜日を入力してくれッッ\n曜日の入力が終わったら、筋トレを行う時間を1時間単位で入力してくれッッ\n入力例:18\n0~23の範囲で入力してくれッッ"
            when "水"
              user.update(wednsday: 1)
              push = 
              "筋トレを行う曜日は#{input}だなッッ\n他の曜日にも筋トレする場合は改めて曜日を入力してくれッッ\n曜日の入力が終わったら、筋トレを行う時間を1時間単位で入力してくれッッ\n入力例:18\n0~23の範囲で入力してくれッッ"
            when "木"
              user.update(thursday: 1)
              push = 
              "筋トレを行う曜日は#{input}だなッッ\n他の曜日にも筋トレする場合は改めて曜日を入力してくれッッ\n曜日の入力が終わったら、筋トレを行う時間を1時間単位で入力してくれッッ\n入力例:18\n0~23の範囲で入力してくれッッ"
            when "金"
              user.update(friday: 1)
              push = 
              "筋トレを行う曜日は#{input}だなッッ\n他の曜日にも筋トレする場合は改めて曜日を入力してくれッッ\n曜日の入力が終わったら、筋トレを行う時間を1時間単位で入力してくれッッ\n入力例:18\n0~23の範囲で入力してくれッッ"
            when "土"
              user.update(saturday: 1)
              push = 
              "筋トレを行う曜日は#{input}だなッッ\n他の曜日にも筋トレする場合は改めて曜日を入力してくれッッ\n曜日の入力が終わったら、筋トレを行う時間を1時間単位で入力してくれッッ\n入力例:18\n0~23の範囲で入力してくれッッ"
            when "日"
              user.update(sunday: 1)
              push = 
              "筋トレを行う曜日は#{input}だなッッ\n他の曜日にも筋トレする場合は改めて曜日を入力してくれッッ\n曜日の入力が終わったら、筋トレを行う時間を1時間単位で入力してくれッッ\n入力例:18\n0~23の範囲で入力してくれッッ"
                # end
                  push = 
                    "筋トレを行う曜日は#{input}だなッッ\n他の曜日にも筋トレする場合は改めて曜日を入力してくれッッ\n曜日の入力が終わったら、筋トレを行う時間を1時間単位で入力してくれッッ\n入力例:18\n0~23の範囲で入力してくれッッ"
            when 0..23
                user.update(workoutTime: input)
                push =
                  "筋トレを行う時間は#{input}だなッッ\n了解したッッ\n指定した曜日の時間になり次第連絡するぞッッ\n改めて設定をする場合は「再設定」とメッセージを送ってくれッッ"
            when /.*(再設定).*/
              user.reset(0)
              user.update(workoutTime: nil)
            #   # 
            #   per06to12 = doc.elements[xpath + 'info[2]/rainfallchance/period[2]'].text
            #   per12to18 = doc.elements[xpath + 'info[2]/rainfallchance/period[3]'].text
            #   per18to24 = doc.elements[xpath + 'info[2]/rainfallchance/period[4]'].text
            #   if per06to12.to_i >= min_per || per12to18.to_i >= min_per || per18to24.to_i >= min_per
            #     push =
            #       "明日の天気だよね。\n明日は雨が降りそうだよ(>_<)\n今のところ降水確率はこんな感じだよ。\n　  6〜12時　#{per06to12}％\n　12〜18時　 #{per12to18}％\n　18〜24時　#{per18to24}％\nまた明日の朝の最新の天気予報で雨が降りそうだったら教えるね！"
            #   else
            #     push =
            #       "明日の天気？\n明日は雨が降らない予定だよ(^^)\nまた明日の朝の最新の天気予報で雨が降りそうだったら教えるね！"
            #   end
            # when /.*(明後日|あさって).*/
            #   per06to12 = doc.elements[xpath + 'info[3]/rainfallchance/period[2]l'].text
            #   per12to18 = doc.elements[xpath + 'info[3]/rainfallchance/period[3]l'].text
            #   per18to24 = doc.elements[xpath + 'info[3]/rainfallchance/period[4]l'].text
            #   if per06to12.to_i >= min_per || per12to18.to_i >= min_per || per18to24.to_i >= min_per
            #     push =
            #       "明後日の天気だよね。\n何かあるのかな？\n明後日は雨が降りそう…\n当日の朝に雨が降りそうだったら教えるからね！"
            #   else
            #     push =
            #       "明後日の天気？\n気が早いねー！何かあるのかな。\n明後日は雨は降らない予定だよ(^^)\nまた当日の朝の最新の天気予報で雨が降りそうだったら教えるからね！"
            #   end
            # when /.*(かわいい|可愛い|カワイイ|きれい|綺麗|キレイ|素敵|ステキ|すてき|面白い|おもしろい|ありがと|すごい|スゴイ|スゴい|好き|頑張|がんば|ガンバ).*/
            #   push =
            #     "ありがとう！！！\n優しい言葉をかけてくれるあなたはとても素敵です(^^)"
            # when /.*(こんにちは|こんばんは|初めまして|はじめまして|おはよう).*/
            #   push =
            #     "こんにちは。\n声をかけてくれてありがとう\n今日があなたにとっていい日になりますように(^^)"
            # else
            #   per06to12 = doc.elements[xpath + 'info/rainfallchance/period[2]l'].text
            #   per12to18 = doc.elements[xpath + 'info/rainfallchance/period[3]l'].text
            #   per18to24 = doc.elements[xpath + 'info/rainfallchance/period[4]l'].text
            #   if per06to12.to_i >= min_per || per12to18.to_i >= min_per || per18to24.to_i >= min_per
            #     word =
            #       ["雨だけど元気出していこうね！",
            #        "雨に負けずファイト！！",
            #        "雨だけどああたの明るさでみんなを元気にしてあげて(^^)"].sample
            #     push =
            #       "今日の天気？\n今日は雨が降りそうだから傘があった方が安心だよ。\n　  6〜12時　#{per06to12}％\n　12〜18時　 #{per12to18}％\n　18〜24時　#{per18to24}％\n#{word}"
            #   else
            #     word =
            #       ["天気もいいから一駅歩いてみるのはどう？(^^)",
            #        "今日会う人のいいところを見つけて是非その人に教えてあげて(^^)",
            #        "素晴らしい一日になりますように(^^)",
            #        "雨が降っちゃったらごめんね(><)"].sample
            #     push =
            #       "今日の天気？\n今日は雨は降らなさそうだよ。\n#{word}"
            #   end
            # end
            # テキスト以外（画像等）のメッセージが送られた場合
          else
            push = "テキスト以外は一向に分からんッッ"
          end
          message = {
            type: 'text',
            text: push
          }
          client.reply_message(event['replyToken'], message)
          # LINEお友達追された場合（機能②）
        when Line::Bot::Event::Follow
          # 登録したユーザーのidをユーザーテーブルに格納
          line_id = event['source']['userId']
          User.create(line_id: line_id)
          # LINEお友達解除された場合（機能③）
        when Line::Bot::Event::Unfollow
          # お友達解除したユーザーのデータをユーザーテーブルから削除
          line_id = event['source']['userId']
          User.find_by(line_id: line_id).destroy
        end
      }
      head :ok
    end
  
    private
  
    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end
  end
end
