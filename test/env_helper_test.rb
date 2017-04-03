require 'test_helper'

describe ENVHelper do

  it 'has a version number' do
    ENVHelper::VERSION.wont_be_nil
  end

  describe '#get' do

    it 'will return the environment variable' do
      ENV['db_name'] = 'foobar'
      ENVHelper.get('db_name').must_equal 'foobar'
    end

    it 'will return the environment variable regardless of case' do
      ENV['DB_PASSWORD'] = 'password'
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

    it 'will return the environment variable as an integer' do
      ENV['socket_timeout'] = '30'
      ev = ENVHelper.int('socket_timeout')
      ev.must_be_kind_of Integer
      ev.must_equal 30
    end

    it 'will return the default value if no environment variable exists' do
      ENV['max_pool_size'] = '25'
      ENVHelper.int('max_pool_size', 25).must_equal 25
    end

    it 'will return 0 if no environment variable exists and no default set' do
      ENVHelper.int('min_pool_size').must_equal 0
    end

  end

  describe '#bool' do

    it 'will return the environment variable as a boolean' do
      ENV['ssl_enabled'] = 'true'
      ev = ENVHelper.bool('ssl_enabled')
      ev.must_be_kind_of(TrueClass || FalseClass)
      ev.must_equal true
    end

    it 'will return the default value if no environment variable exists' do
      ENVHelper.bool('sharding_enabled', false).must_equal false
    end

    it 'will return nil if no environment variable exists and no default set' do
      ENVHelper.bool('sharding_enabled').must_be_nil
    end

  end

  describe '#array' do
    expected_result = %w(db1.foobar.com db2.foobar.com db3.foobar.com)

    it 'will return the environment variable as an array' do
      ENV['db_hosts'] = 'db1.foobar.com db2.foobar.com db3.foobar.com'
      clear_config
      ev = ENVHelper.array('db_hosts')
      ev.must_be_kind_of Array
      ev.must_equal expected_result
    end

    it 'will use the configured array seperator' do
      ENV['db_hosts'] = 'db1.foobar.com\ndb2.foobar.com\ndb3.foobar.com'
      ENVHelper.array_seperator = '\n'
      ev = ENVHelper.array('db_hosts')
      ev.must_be_kind_of Array
      ev.must_equal expected_result
    end

    it 'will return the default value if no environment variable exists' do
      ev = ENVHelper.array('db_hostnames', expected_result)
      ev.must_be_kind_of Array
      ev.must_equal expected_result
    end

    it 'will return an empty array if no environment variable exists and no default set' do
      ev = ENVHelper.array('db_passwords')
      ev.must_be_kind_of Array
      ev.must_be_empty
    end
  end

  describe '#hash' do
    expected_result = { 'key1' => 'abcdef', 'key2' => 'fedcba' }

    it 'will return the environment variable as a hash' do
      ENV['private_keys'] = 'key1:abcdef key2:fedcba'
      clear_config
      ev = ENVHelper.hash('private_keys')
      ev.must_be_kind_of Hash
      ev.must_equal(expected_result)
    end

    it 'will use the configured hash key group seperator' do
      ENV['private_keys'] = 'key1:abcdef\nkey2:fedcba'
      clear_config
      ENVHelper.hash_key_seperator = '\n'
      ev = ENVHelper.hash('private_keys')
      ev.must_be_kind_of Hash
      ev.must_equal(expected_result)
    end

    it 'will use the configured key value seperator' do
      ENV['private_keys'] = 'key1|abcdef key2|fedcba'
      clear_config
      ENVHelper.hash_key_value_seperator = '|'
      ev = ENVHelper.hash('private_keys')
      ev.must_be_kind_of Hash
      ev.must_equal(expected_result)
    end

    it 'will return the default value if no environment variable exists' do
      clear_config
      ev = ENVHelper.hash('public_keys', expected_result)
      ev.must_be_kind_of Hash
      ev.must_equal(expected_result)
    end

    it 'will return an empty hash if no environment variable exists and no default is set' do
      ev = ENVHelper.hash('public_keys')
      ev.must_be_kind_of Hash
      ev.must_be_empty
    end

  end

  describe '#array_seperator' do
    it 'returns the default array seperator' do
      clear_config
      ENVHelper.array_seperator.must_equal ' '
    end

    it 'returns the configured array seperator' do
      ENVHelper.array_seperator = '\n'
      ENVHelper.array_seperator.must_equal '\n'
    end
  end

  describe '#hash_key_seperator' do
    it 'returns the default hash key seperator' do
      clear_config
      ENVHelper.hash_key_seperator.must_equal ' '
    end

    it 'returns the configured hash key seperator' do
      ENVHelper.hash_key_seperator = '\n'
      ENVHelper.hash_key_seperator.must_equal '\n'
    end
  end

  describe '#hash_key_value_seperator' do
    it 'returns the default hash key value seperator' do
      clear_config
      ENVHelper.hash_key_value_seperator.must_equal ':'
    end

    it 'returns the configured hash key value seperator' do
      ENVHelper.hash_key_value_seperator = '|'
      ENVHelper.hash_key_value_seperator.must_equal '|'
    end
  end

  # used to clear any config settings between tests
  def clear_config
    ENVHelper.array_seperator = nil
    ENVHelper.hash_key_seperator = nil
    ENVHelper.hash_key_value_seperator = nil
  end

end
