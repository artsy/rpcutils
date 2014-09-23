$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name = 'rpcutils'
  gem.homepage = 'http://github.com/artsy/rpcutils'
  gem.license = 'MIT'
  gem.summary = %(rpc clients.)
  gem.version = '0.42'

  gem.description = <<-EOS
    Repository of rpc clients.
  EOS

  gem.email = ['anil@artsymail.com']
  gem.authors = ['Anil Bawa-Cavia']

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- spec/*`.split("\n")

  gem.add_runtime_dependency 'typhoeus'
  gem.add_development_dependency 'rspec'
end
