$:.unshift File.expand_path("../lib", __FILE__)

Gem::Specification.new do |gem|
  gem.name = "rpcutils"
  gem.homepage = "http://github.com/artsy/rpcutils"
  gem.license = "MIT"
  gem.summary = %Q{rpc clients.}
  gem.version = '0.2'

  gem.description = <<-EOS
    Repository of rpc clients.
  EOS

  gem.email = ["anil@artsymail.com"]
  gem.authors = ["Anil Bawa-Cavia"]

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- spec/*`.split("\n")

  gem.add_runtime_dependency "typhoeus", "~> 0.4.2"
  gem.add_development_dependency 'rspec', '~> 2.13.0'
end
