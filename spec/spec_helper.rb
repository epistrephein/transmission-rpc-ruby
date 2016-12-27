require 'rubygems'
require 'webmock/rspec'
require 'coveralls'
Coveralls.wear!

require_relative File.join('..', 'lib', 'transmission')
require_relative File.join('helpers', 'stubs')

ENV['TESTING'] = 'true'

RSpec.configure do |config|
  config.include Stubs
end
