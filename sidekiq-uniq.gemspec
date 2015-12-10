# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/uniq/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-uniq"
  spec.version       = Sidekiq::Uniq::VERSION
  spec.authors       = ["Caio SBA"]
  spec.email         = ["caiosba@gmail.com"]

  spec.summary       = %q{Unique enqueued/processing jobs for Sidekiq}
  spec.description   = %q{This is a Sidekiq extension that doesn't allow a job to be enqueued if it's already in the queue or being processed}
  spec.homepage      = "https://github.com/caiosba/sidekiq-uniq"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "sidekiq"
end
