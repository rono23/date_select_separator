$:.push File.expand_path('../lib', __FILE__)

require 'date_select_separator/version'

Gem::Specification.new do |s|
  s.name        = 'date_select_separator'
  s.version     = DateSelectSeparator::VERSION
  s.authors     = ['rono23']
  s.email       = ['rono23@gmail.com']
  s.homepage    = 'https://github.com/rono23/date_select_separator'
  s.summary     = 'Add separators to data_select on Rails.'
  s.description = 'Add separators to data_select on Rails.'
  s.license     = 'MIT'
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  s.add_development_dependency 'bundler', '~> 1.11'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'minitest', '~> 5.0'
  s.add_development_dependency 'rails'
  s.add_development_dependency 'sqlite3'
end
