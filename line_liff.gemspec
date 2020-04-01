
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "line_liff/version"

Gem::Specification.new do |spec|
  spec.name          = "line_liff"
  spec.version       = LineLiff::VERSION
  spec.authors       = ["mosle"]
  spec.email         = ["yskysd@gmail.com"]

  spec.summary       = "line liff api gem"
  spec.description   = "implementation line liff api for ruby using line-bot-sdk-ruby"
  spec.homepage      = "https://github.com/mosle/line_liff"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency "addressable", "~> 2.6"
  spec.add_development_dependency "webmock", "~> 3.5.1"

  spec.add_dependency "line-bot-api","~>1.14"
end
