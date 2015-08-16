# Chilexpress

Get Chilexpress shipment information.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chilexpress'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chilexpress

## Usage

```ruby
# you must provide a valid Chilexpress order code
order_code = 123456

# this will take a while, Chilexpress's site response time is quite slow
result = Chilexpress.get_order(order_code)

# you can get the following shipment information
puts result.order_number
puts result.product_type
puts result.service_type
puts result.status

# if the shipment has been delivered, you can get the receiver's details
receiver = result.receiver

if receiver
  puts receiver.name
  puts receiver.rut
  puts receiver.delivery_date
  puts receiver.delivery_time  
end

# you can also get the detailed tracking information
result.tracking_entries.each do |entry|
  puts entry.date
  puts entry.time
  puts entry.activity
end
```

## Todo

- Write tests.
- Multi thread ```Chilexpress.get_orders(order_number_array)``` method.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/holamendi/chilexpress/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
