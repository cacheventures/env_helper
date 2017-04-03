require 'test_helper'

describe ENVHelper do

  it 'has a version number' do
    ENVHelper::VERSION.wont_be_nil
  end

  describe '#get' do
    ENV['db_name'] = 'foobar'
    ENV['DB_PASSWORD'] = 'password'

    it 'will return the environment variable' do
      ENVHelper.get('db_name').must_equal 'foobar'
    end

    it 'will return the environment variable regardless of case' do
      ENVHelper.get('db_password').must_equal 'password'
    end

    it 'will return the default value if no environment variable exists' do
      ENVHelper.get('db_hostname', 'database.com').must_equal 'database.com'
    end

    it 'will return nil if no environment variable exists and no default set' do
      ENVHelper.get('db_hostname').must_be_nil
    end
  end

  describe '#int' do
    ENV['socket_timeout'] = '30'
    ENV['max_pool_size'] = '25'

    it 'will return the environment variable as an integer' do
      ENVHelper.int('socket_timeout').must_be_kind_of Integer
      ENVHelper.int('socket_timeout').must_equal 30
    end

    it 'will return the default value if no environment variable exists' do
      ENVHelper.int('max_pool_size', 25).must_equal 25
    end

    it 'will return 0 if no environment variable exists and no default set' do
      ENVHelper.int('min_pool_size').must_equal 0
    end

  end

  describe '#bool' do
    ENV['ssl_enabled'] = 'true'

    it 'will return the environment variable as a boolean' do
      ENVHelper.bool('ssl_enabled').must_be_kind_of(TrueClass || FalseClass)
      ENVHelper.bool('ssl_enabled').must_equal true
    end

    it 'will return the default value if no environment variable exists' do
      ENVHelper.bool('sharding_enabled', false).must_equal false
    end

    it 'will return nil if no environment variable exists and no default set' do
      ENVHelper.bool('sharding_enabled').must_be_nil
    end

  end

end
