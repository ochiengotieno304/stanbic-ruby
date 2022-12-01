# Stanbic
Stanbic Payment APIs ruby sdk

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add stanbic

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install stanbic

## Usage
### Initialize Stanbic Client

```ruby
client = Stanbic::Client.new(api_key: ENV['STANBIC_API_KEY'], api_secret: ENV['STANBIC_API_SECRET)
```

### Make Stanbic Payments
```ruby
client.stanbic_payments(to_account, amount, originator_phone)
```

### Make Mobile Payments
```ruby
client.stanbic_payments(to_account, amount, originator_phone)
```

## Development

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/stanbic.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
