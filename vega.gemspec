require_relative "lib/vega/version"

Gem::Specification.new do |spec|
  spec.name          = "vega"
  spec.version       = Vega::VERSION
  spec.summary       = "Interactive charts for Ruby, powered by Vega and Vega-Lite"
  spec.homepage      = "https://github.com/ankane/vega"
  spec.license       = "BSD-3-Clause"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@chartkick.com"

  spec.files         = Dir["*.{md,txt}", "{lib,licenses,vendor}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.5"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", ">= 5"
end
