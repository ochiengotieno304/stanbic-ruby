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
require "stanbic"
@client = Stanbic::Client.new(api_key: ENV['STANBIC_API_KEY'], api_secret: ENV['STANBIC_API_SECRET)
```

Make API calls using the @client object

### Payments to Stanbic Accounts
```ruby
send_to_stanbic = @client.stanbic_payments(to_account, amount)
```

- `to_account`: stanbic recipient account number`REQUIRED`
- `amount`: amount to transact `REQUIRED`

### Inter-Bank Transfers API via Pesalink
```ruby
inter_bank_transfer = @client.stanbic_payments(to_account, amount)
```

- `to_account`: stanbic recipient account number`REQUIRED`
- `amount`: amount to transact `REQUIRED`



### Send Money to Mobile Money APIs
```ruby
mobile_transfer = @client.mobile_payments(sender, receipient, amount, provider)
```
- `sender`: sender mobile number`REQUIRED`
- `receipient`: receipient mobile number `REQUIRED`
- `amount`: amount to transact `REQUIRED`
- `provider`: mobile provider `REQUIRED`

- providers :
  - MPESA
  - T-KASH
  -  AIRTEL MONEY


## Development

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ochiengotieno304/stanbic.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
