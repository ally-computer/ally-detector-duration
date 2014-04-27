# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ally/detector/duration/version'

Gem::Specification.new do |spec|
  spec.name          = "ally-detector-duration"
  spec.version       = Ally::Detector::Duration::VERSION
  spec.authors       = ["Chad Barraford"]
  spec.email         = ["cbarraford@gmail.com"]
  spec.description   = %q{Ally detector that detects a duration of time (ie 5 minutes ro 12 hours)}
  spec.summary       = %q{Ally detector that detects a duration of time}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ["lib"]

  spec.add_dependency 'ally'

  # development dependencies
  spec.add_development_dependency "bundler", "~> 1.3"
  %W( rake rspec rubocop ).each do |gem|
    spec.add_development_dependency gem
  end
end
