# ENVHelper 
By [Cache Ventures](https://cacheventures.com)

[![Build Status](https://travis-ci.org/cacheventures/env_helper.svg?branch=master)](https://travis-ci.org/cacheventures/env_helper)

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
ENV['phi'] = '1.61803'
ENV['ssl_enabled'] = 'true'
ENV['db_hosts'] = 'db1.foobar.com db2.foobar.com db3.foobar.com'
ENV['favorite_people'] = 'tom jones,joe smith,jebediah mason'
ENV['private_keys'] = 'key1:abcdef key2:fedcba'

ENVHelper.get('db_name')
"foobar"

ENVHelper.get('db_password')
"password"

ENVHelper.int('max_pool_size')
25

ENVHelper.int('socket_timeout', 30)
30

ENVHelper.float('phi')
1.61803

ENVHelper.float('pi', 3.141592)
3.141592

ENVHelper.bool('ssl_enabled')
true

ENVHelper.bool('sharding_enabled', false)
false

ENVHelper.array('db_hosts')
['db1.foobar.com', 'db2.foobar.com', 'db3.foobar.com']

ENVHelper.array('favorite_people', nil, ',')
['tom jones', 'joe smith', 'jebediah mason']

ENVHelper.hash('private_keys')
{ 'key1' => 'abcdef', 'key2' => 'fedcba' }
```

## Notes
All methods accept a default value as a second parameter and that parameter
should be the type being returned. For example if you call
`ENVHelper.int('max_pool_size', 25)` the second parameter is an Integer.

## Configuration

```ruby
# string used to split the environment variable to make the array
ENVHelper.array_seperator = ' ' # default is a space

# string used to split the hash key value groups in the hash
ENVHelper.hash_key_seperator = ' ' # default is a space

# string used to split the key from values in the hash
ENVHelper.hash_key_value_seperator = ':' # default is a colon

# whether or not to raise errors for empty environment variables
ENVHelper.raise_errors = true # defaults to false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cacheventures/env_helper.
