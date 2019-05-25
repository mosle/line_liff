# LineLiff

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/line_liff`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'line_liff'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install line_liff

## Usage

see https://developers.line.biz/ja/reference/liff/

```ruby
liff_client = Line::Bot::LiffClient.new{|config|
    config.channel_token = "your channel token"
}
response = liff_client.get_liffs #https://developers.line.biz/ja/reference/liff/#get-all-liff-apps

response = liff_client.create_liff "compact","https://url-of-liff-app","any-description"
#https://developers.line.biz/ja/reference/liff/#add-liff-app

response = liff_client.delete_liff "id-of-any-liff"
#https://developers.line.biz/ja/reference/liff/#delete-liff-app


response = liff_client.update_liff "id-of-any-liff","compact","https://url-of-liff-app","any-description"
#https://developers.line.biz/ja/reference/liff/#update-liff-app

```

OR
```ruby
liff_client = Line::Bot::LiffClient.create_by_line_bot_client working_line_bot_client #https://github.com/line/line-bot-sdk-ruby

#..same as listed above

```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mosle/line_liff.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
