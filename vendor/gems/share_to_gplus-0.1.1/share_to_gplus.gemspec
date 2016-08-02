# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'share_to_gplus/version'

Gem::Specification.new do |gem|
  gem.authors       = ['Andrey Eremin']
  gem.email         = ['dsoft88@gmail.com']
  gem.description   = 'Share text and links to Google+ community'
  gem.summary       = 'Share text and links to Google+ community'
  gem.homepage      = 'https://github.com/developer88/share_to_google_plus'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = ['sharetogplus']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'share_to_gplus'
  gem.require_paths = ['lib']
  gem.version       = ShareToGplus::VERSION
  gem.license       = 'GPL-3.0'

  gem.required_ruby_version = '>=2.3'

  gem.add_runtime_dependency 'capybara', '>=2'
  gem.add_runtime_dependency 'selenium-webdriver'
  gem.add_runtime_dependency 'poltergeist'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
end
