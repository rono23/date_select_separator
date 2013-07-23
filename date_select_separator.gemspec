# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date_select_separator/version'

Gem::Specification.new do |spec|
  spec.name          = "date_select_separator"
  spec.version       = DateSelectSeparator::VERSION
  spec.authors       = ["rono23"]
  spec.email         = ["rono23@gmail.com"]
  spec.description   = %q{Add separators to data_select on Rails}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/rono23/date_select_separator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 3.2.12"
end
