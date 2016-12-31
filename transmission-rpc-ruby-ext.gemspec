Gem::Specification.new do |spec|
  spec.name          = 'transmission-rpc-ruby-ext'
  spec.version       = '0.1.0'
  spec.date          = '2016-12-28'

  spec.authors       = ['Tommaso Barbato']
  spec.email         = 'epistrephein@gmail.com'

  spec.summary       = 'Extended fork of transmission-rpc-ruby.'
  spec.description   = 'A fork of transmission-rpc-ruby with shortcut methods and revised codebase.'
  spec.homepage      = 'https://github.com/epistrephein/transmission-rpc-ruby-ext'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0'

  spec.add_dependency 'faraday', '~> 0.10'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'webmock', '~> 2.3'
  spec.add_development_dependency 'rake', '~> 12.0'
end
