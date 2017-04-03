# ENVHelper

ENVHelper makes it easy to manage your environment variables when you have
different types like Booleans or Integers without having to check and convert.
It also makes it so you don't have to worry about environment variables being
uppercase or lowercase.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'env_helper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install env_helper

## Usage

```ruby

ENV['db_name'] = 'foobar'
ENV['DB_PASSWORD'] = 'password'
ENV['max_pool_size'] = '25'
ENV['ssl_enabled'] = 'true'

ENVHelper.get('db_name')
"foobar"

ENVHelper.get('db_password')
"password"

ENVHelper.int('max_pool_size')
25

ENVHelper.int('socket_timeout', 30)
30

ENVHelper.bool('ssl_enabled')
true

ENVHelper.bool('sharding_enabled', false)
false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/env_helper.
