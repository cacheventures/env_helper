# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'env_helper/version'

Gem::Specification.new do |gem|
  gem.name          = 'env_helper'
  gem.version       = ENVHelper::VERSION
  gem.authors       = ['Jarrett Lusso']
  gem.email         = ['jarrett@cacheventures.com']

  gem.summary       = %q{An easy way to manage environment variables with types besides plain strings.}
  gem.description   = %q{An easy way to manage environment variables with types besides plain strings.}
  gem.homepage      = 'https://cacheventures.com'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if gem.respond_to?(:metadata)
    gem.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  gem.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'bundler', '~> 1.13'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'awesome_print'
  gem.add_development_dependency 'minitest', '~> 5.0'
  gem.add_development_dependency 'minitest-reporters'
end
