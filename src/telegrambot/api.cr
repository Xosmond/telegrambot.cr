require "http/client"
require "json"

module Telegrambot
  class Api
    property headers : HTTP::Headers
    property client : HTTP::Client

    # Create an instance of the API with the *token*
    #
    # ```
    # Telegrambot::Api.new token
    # ```
    # You can also get the token from env
    # ```
    # Telegrambot::Api.new ENV["TELEGRAM_BOT_TOKEN"]
    # ```
    def initialize(@token : String)
      @endpoint = "https://api.telegram.org"
      @client = HTTP::Client.new URI.parse(@endpoint)
      headers = HTTP::Headers.new
      headers.add "Content-Type", "application/json"
      @headers = headers
    end

    # Sends a *message* to the chat with the *chat_id* specified
    #
    # ```
    # api.send_message chat_id: 1231241, message: "Hello" # => true
    # ```
    def send_message(chat_id : Int, message : String)
      json = call(get_path("/sendMessage"), {chat_id: chat_id.to_s, text: message})
      if json["ok"].as_bool
        true
      else
        raise Telegrambot::Exceptions::ResponseError.new ("Couldnt send the message")
      end
    end

    # Get updates from the bot sice the last *offset*
    #
    # Get all updates
    # ```
    # api.get_updates 0 # => 13171, [Messages]
    # ```
    # Get since offset
    # ```
    # api.get_updates offset: 1231796 # => 1231886, [Messages]
    # ```
    def get_updates(offset : Int)
      json = call(get_path("/getUpdates"), {offset: offset.to_s})
      if json["ok"].as_bool
        json_messages = json["result"]
        messages = [] of Telegrambot::Message
        json_messages.each do |json_message|
          messages << Telegrambot::Message.new(json_message["message"])
          offset = json_message["update_id"].as_i
        end
        if json_messages.size > 0
          return (offset + 1), messages
        else
          return offset, messages
        end
      else
        raise Telegrambot::Exceptions::ResponseError.new ("Couldnt get updates")
      end
    end

    # Listen for updates and use the block on each message
    #
    # ```
    # api.listen(0) do |message|
    #   puts message.text # => Hello
    # end
    # ```
    def listen(offset : Int)
      offset ||= 0
      while true
        offset, messages = get_updates(offset: offset)
        messages.each do |message|
          yield message
        end
      end
    end

    # :nodoc:
    private def client
      @client ||= HTTP::Client.new URI.parse(@endpoint)
    end

    # :nodoc:
    private def headers
      @headers ||= begin
        headers = HTTP::Headers.new
        headers.add "Content-Type", "application/json"
        headers
      end
    end

    # :nodoc:
    private def get_path(path)
      "/bot#{@token}" + path
    end

    # :nodoc:
    private def call(path, data)
      response = client.post path, headers: headers, form: data
      JSON.parse(response.body)
    end

    # :nodoc:
    def finalize
      client.close
    end
  end
end
