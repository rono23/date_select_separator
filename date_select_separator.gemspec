$:.push File.expand_path('../lib', __FILE__)

require 'date_select_separator/version'

Gem::Specification.new do |s|
  s.name        = 'date_select_separator'
  s.version     = DateSelectSeparator::VERSION
  s.authors     = ['rono23']
  s.email       = ['rono23@gmail.com']
  s.homepage      = 'https://github.com/rono23/date_select_separator'
  s.summary     = 'Add separators to data_select on Rails.'
  s.description = 'Add separators to data_select on Rails.'

  s.files = Dir["{app,config,db,lib}/**/*", 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '>= 4.0.0'

  s.add_development_dependency 'sqlite3'
end
