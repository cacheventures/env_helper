require "env_helper/version"

module ENVHelper
  class << self
    attr_accessor :array_separator
    attr_accessor :hash_key_separator
    attr_accessor :hash_key_value_separator
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

  def self.array(name, default = nil, array_sep = nil)
    var = get(name, default)
    return [] if var.nil?
    return var if var.is_a? Array
    array_separator = array_sep || @array_separator || ' '
    var.split(array_separator)
  end

  def self.hash(name, default = nil)
    var = get(name, default)
    return {} if var.nil?
    return var if var.is_a? Hash
    hash_array = var.split(@hash_key_separator || ' ')
    hash_array.map do |kv|
      kv.split(@hash_key_value_separator || ':')
    end.to_h
  end

end
