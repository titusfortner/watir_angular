# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "watir_angular"
  spec.version       = "0.4.1"
  spec.authors       = ["Titus Fortner"]
  spec.email         = ["titusfortner@gmail.com"]

  spec.summary       = %q{Custom support for using Watir with Angular based websites.}
  spec.description   = %q{Adds direct support for Angular specific locators and waiting strategies for use with Watir}
  spec.homepage      = 'http://github.com/titusfortner/watir_angular'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "watir", "~> 6.12"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webdrivers", "~> 3.0"
end
