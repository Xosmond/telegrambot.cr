module Telegrambot
  class FromMessage
    getter id : Int64
    getter is_bot : Bool
    getter first_name : String
    getter last_name : String
    getter username : String
    getter language_code : String

    def initialize(@json : JSON::Any)
      @id = @json["id"].as_i64
      @is_bot = @json["is_bot"].as_bool
      @first_name = @json["first_name"].as_s
      @last_name = @json["last_name"].as_s
      @username = @json["username"].as_s
      @language_code = @json["language_code"].as_s
    end
  end
end
