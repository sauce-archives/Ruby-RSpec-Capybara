# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'rspec'
require 'simple_sauce'
require 'simple_sauce/extensions/capybara'

Capybara.default_max_wait_time = 10

#
# Note that having this as a conditional in the test code is less ideal
# It is better for static data to be pulled from a serialized file like a yaml
#
# Note: not all browsers are defaulting to using w3c protocol
# This will change soon. Where possible prefer the w3c approach
#
def platform
  ENV['PLATFORM'] ||= 'mac_sierra_chrome'

  case ENV['PLATFORM']
  when 'windows_10_edge'
    {platform_name: 'Windows 10',
     browser_name: 'edge',
     browser_version: '18.17763'}
  when 'windows_8_ie'
    {platform: 'Windows 8.1',
     browser_name: 'ie',
     version: '11.0'}
  when 'mac_sierra_chrome'
    {platform_name: 'macOS 10.12',
     browser_name: 'chrome',
     browser_version: '65.0'}
  when 'mac_mojave_safari'
    {platform_name: 'macOS 10.14',
     browser_name: 'safari',
     browser_version: '12.0'}
  when 'windows_7_ff'
    {platform_name: 'Windows 7',
     browser_name: 'firefox',
     browser_version: '60.0'}
  end
end

#
# These are the Sauce Labs specific options
# Everything here is supported: https://wiki.saucelabs.com/display/DOCS/Platform+Configurator#/
#
opts = platform.merge(screen_resolution: '1080x720',
                       command_timeout: 90)

sauce_options = SimpleSauce::Options.new(opts)

session = SimpleSauce::Session.new(sauce_options)
session.data_center = ENV['SAUCE_DATA_CENTER']&.to_sym if ENV['SAUCE_DATA_CENTER']

SimpleSauce.register_capybara_driver(session)

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers

  config.before(:each) do |test|
    @session = SimpleSauce.session
    @session.test_name = test.full_description
    @session.start
  end

  config.after(:each) do |test|
    @session.stop(!test.exception)
  end
end
