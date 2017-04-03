require "env_helper/version"

module ENVHelper
  class << self
    attr_accessor :array_seperator
    attr_accessor :hash_key_seperator
    attr_accessor :hash_key_value_seperator
  end

  def self.get(name, default = nil)
    var = ENV[name] || ENV[name.upcase]
    var.nil? ? default : var
  end

  def self.int(name, default = nil)
    get(name, default).to_i
  end

  def self.bool(name, default = nil)
    case get(name, default).to_s
    when 'true'
      true
    when 'false'
      false
    end
  end

  def self.array(name, default = nil)
    var = get(name, default)
    return [] if var.nil?
    return var if var.is_a? Array
    var.split(array_seperator)
  end

  def self.hash(name, default = nil)
    var = get(name, default)
    return {} if var.nil?
    return var if var.is_a? Hash
    hash_array = var.split(hash_key_seperator)
    hash_array.map do |kv|
      kv.split(hash_key_value_seperator)
    end.to_h
  end

  private

  def self.array_seperator
    @array_seperator || ' '
  end

  def self.hash_key_seperator
    @hash_key_seperator || ' '
  end

  def self.hash_key_value_seperator
    @hash_key_value_seperator || ':'
  end

end
