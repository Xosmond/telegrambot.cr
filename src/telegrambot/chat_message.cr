module Telegrambot
  class ChatMessage
    getter id : Int64
    getter first_name : String
    getter last_name : String
    getter username : String
    getter ttype : String

    def initialize(@json : JSON::Any)
      @id = @json["id"].as_i64
      @first_name = @json["first_name"].as_s
      @last_name = @json["last_name"].as_s
      @username = @json["username"].as_s
      @ttype = @json["type"].as_s
    end
  end
end
