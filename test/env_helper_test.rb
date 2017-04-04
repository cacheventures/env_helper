require 'test_helper'

describe ENVHelper do

  it 'has a version number' do
    ENVHelper::VERSION.wont_be_nil
  end

  before do
    ENVHelper.array_separator = nil
    ENVHelper.hash_key_separator = nil
    ENVHelper.hash_key_value_separator = nil
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
      ev.must_be_kind_of Fixnum
      ev.must_equal 30
    end

    it 'will return the default value if no environment variable exists' do
      ev = ENVHelper.int('max_pool_size', 25)
      ev.must_be_kind_of Fixnum
      ev.must_equal 25
    end

    it 'will return 0 if no environment variable exists and no default set' do
      ev = ENVHelper.int('min_pool_size')
      ev.must_be_kind_of Fixnum
      ev.must_equal 0
    end

  end

  describe '#bool' do

    it 'will return the environment variable as a boolean' do
      ENV['ssl_enabled'] = 'true'
      ENVHelper.bool('ssl_enabled').must_equal true
    end

    it 'will return the default value if no environment variable exists' do
      ENVHelper.bool('sharding_enabled', false).must_equal false
    end

    it 'will return nil if no environment variable exists and no default set' do
      ENVHelper.bool('sharding_enabled').must_be_nil
    end

  end

  describe '#array' do
    expected = %w(db1.foobar.com db2.foobar.com db3.foobar.com)

    it 'will return the environment variable as an array' do
      ENV['db_hosts'] = 'db1.foobar.com db2.foobar.com db3.foobar.com'
      ENVHelper.array('db_hosts').must_equal expected
    end

    it 'will use the configured array separator' do
      ENV['db_hosts'] = 'db1.foobar.com\ndb2.foobar.com\ndb3.foobar.com'
      ENVHelper.array_separator = '\n'
      ENVHelper.array('db_hosts').must_equal expected
    end

    it 'will return the default value if no environment variable exists' do
      ENVHelper.array('db_hostnames', expected).must_equal expected
    end

    it 'will return an empty array if no environment variable exists and no default set' do
      ev = ENVHelper.array('db_passwords')
      ev.must_be_kind_of Array
      ev.must_be_empty
    end
  end

  describe '#hash' do
    expected = { 'key1' => 'abcdef', 'key2' => 'fedcba' }

    it 'will return the environment variable as a hash' do
      ENV['private_keys'] = 'key1:abcdef key2:fedcba'
      ENVHelper.hash('private_keys').must_equal(expected)
    end

    it 'will use the configured hash key group separator' do
      ENV['private_keys'] = 'key1:abcdef\nkey2:fedcba'
      ENVHelper.hash_key_separator = '\n'
      ENVHelper.hash('private_keys').must_equal(expected)
    end

    it 'will use the configured key value separator' do
      ENV['private_keys'] = 'key1|abcdef key2|fedcba'
      ENVHelper.hash_key_value_separator = '|'
      ENVHelper.hash('private_keys').must_equal(expected)
    end

    it 'will return the default value if no environment variable exists' do
      ENVHelper.hash('public_keys', expected).must_equal(expected)
    end

    it 'will return an empty hash if no environment variable exists and no default is set' do
      ev = ENVHelper.hash('public_keys')
      ev.must_be_kind_of Hash
      ev.must_be_empty
    end

  end

end
