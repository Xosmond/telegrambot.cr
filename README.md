# telegrambot
[![Build Status](https://travis-ci.org/xosmond/telegrambot.cr.svg?branch=master)](https://travis-ci.org/xosmond/telegrambot.cr)

Crystal wrapper for [Telegram's Bot API](https://core.telegram.org/bots/api).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  telegrambot:
    github: xosmond/telegrambot
```

And then execute:

```shell
$ shards install
```

## Usage

First things first, you need to [obtain a token](https://core.telegram.org/bots#botfather) for your bot. Then create your Telegram bot like this:

```crystal
require "telegrambot"

token = "YOUR_TELEGRAM_BOT_API_TOKEN"
bot = Telegrambot::Api.new token
bot.listen(0) do |message|
  case message.text
  when "/start"
    bot.send_message(chat_id: message.chat.id, message: "Hello, #{message.from.first_name}")
  when "/stop"
    bot.send_message(chat_id: message.chat.id, message: "Bye, #{message.from.first_name}")
  end
end
```

Note that `Telegrambot::Api` only implements `send_message`, `get_updates` and `listen` for continues updates. As you can see methods are implemented with the *snake_case* notation.

About `message` object - it implements only the mandatory data, for extra data, you can make a PR.


## Development

- [x] Basic API for recieve and send messages
- Complete Message object for access all possible data
- Logging
- Webhooks
- File uploads
- Custom keyboards

## Contributing

1. Fork it ( https://github.com/xosmond/telegrambot/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [xosmond](https://github.com/xosmond) Jordano Moscoso - creator, maintainer
