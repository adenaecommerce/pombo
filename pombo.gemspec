# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pombo/version'

Gem::Specification.new do |spec|
  spec.name          = 'pombo'
  spec.version       = Pombo::VERSION
  spec.authors       = ['Leandro Nunes']
  spec.email         = ['leandronunes.dev@gmail.com']

  spec.summary       = %q{ Gem to manage the shipping packages using the webservice of the Correios (Brazilian Post Service) }
  spec.description   = %q{ Pombo is a gem that allows the use of webservices the Correios (Brazilian Post Service) of sending packets to check price, delivery time and progress of service }
  spec.homepage      = 'https://github.com/adenaecommerce/pombo'
  spec.license       = 'MIT'
  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = '~> 2.1'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'i18n', '~> 0.7.0'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6'
  spec.add_runtime_dependency 'sax-machine', '~> 1.3'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 11.1'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'pry', '~> 0.10.3'
  spec.add_development_dependency 'webmock', '~> 2.0'
  spec.add_development_dependency 'yard', '~> 0.8.7.6'
end
