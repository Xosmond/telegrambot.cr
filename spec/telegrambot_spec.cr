require "./spec_helper"
require "dotenv"
Dotenv.load

describe Telegrambot::Api do
  describe "Send Message Method" do
    describe "with valid Token" do
      it "with valid chat_id success" do
        api = Telegrambot::Api.new ENV["TELEGRAM_BOT_TOKEN"]
        chat_id = ENV["CHAT_ID"].to_i
        api.send_message(chat_id: chat_id, message: "Hello").should eq true
      end

      it "with invalid chat_id error" do
        api = Telegrambot::Api.new ENV["TELEGRAM_BOT_TOKEN"]
        expect_raises Telegrambot::Exceptions::ResponseError do
          api.send_message(chat_id: 0, message: "Hello")
        end
      end
    end

    it "with invalid token get false" do
      api = Telegrambot::Api.new "xx"
      chat_id = ENV["CHAT_ID"].to_i
      expect_raises Telegrambot::Exceptions::ResponseError do
        api.send_message(chat_id: chat_id, message: "Hello")
      end
    end
  end

  describe "Get Updates Method" do
    describe "with valid Token" do
      it "with valid chat_id success" do
        api = Telegrambot::Api.new ENV["TELEGRAM_BOT_TOKEN"]
        api.get_updates(offset: 0).should be_a Tuple(Int32, Array(Telegrambot::Message))
      end

      it "with invalid chat_id error" do
        api = Telegrambot::Api.new "xx"
        expect_raises Telegrambot::Exceptions::ResponseError do
          api.get_updates(offset: 0)
        end
      end
    end
  end
end
