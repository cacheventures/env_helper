require "env_helper/version"

module ENVHelper

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

end
