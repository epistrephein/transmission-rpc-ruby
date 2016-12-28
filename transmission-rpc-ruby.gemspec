Gem::Specification.new do |s|
  s.name        = 'transmission-rpc-ruby-ext'
  s.version     = '0.1.0'
  s.date        = '2016-12-28'
  s.summary     = 'Extended version of transmission-rpc-ruby.'
  s.description = 'A fork of transmission-rpc-ruby with some shortcut methods added.'
  s.authors     = ['Tommaso Barbato']
  s.email       = 'epistrephein@gmail.com'
  s.files       = `git ls-files`.split($/)
  s.homepage    = 'https://github.com/epistrephein/transmission-rpc-ruby-ext'
  s.license     = 'MIT'
  s.require_paths = ['lib']
  s.add_dependency 'faraday', '~> 0.10'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'webmock', '~> 2.3'
  s.add_development_dependency 'rake', '~> 12.0'
end
