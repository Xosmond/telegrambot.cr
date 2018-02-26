module Telegrambot
  class Message
    getter id : Int64
    getter from : FromMessage
    getter chat : ChatMessage
    getter date : Time
    getter text : String

    def initialize(@json : JSON::Any)
      @id = @json["message_id"].as_i64
      @from = Telegrambot::FromMessage.new(@json["from"])
      @chat = Telegrambot::ChatMessage.new(@json["chat"])
      @date = Time.new seconds: @json["date"].as_i64, nanoseconds: 0, kind: Time::Kind::Local
      @text = @json["text"].as_s
    end
  end
end
