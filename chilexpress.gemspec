# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chilexpress/version'

Gem::Specification.new do |spec|
  spec.name          = "chilexpress"
  spec.version       = Chilexpress::VERSION
  spec.authors       = ["Pablo Orellana Mendiburú"]
  spec.email         = ["hola@mendi.cl"]

  spec.summary       = %q{Chilexpress tracking}
  spec.description   = %q{Provides a simple interface to track orders from Chilexpress}
  spec.homepage      = "https://github.com/holamendi/chilexpress"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri', '~> 1.6.6.2'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
