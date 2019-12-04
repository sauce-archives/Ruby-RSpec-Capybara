# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'rspec'
require 'simple_sauce'

Capybara.default_max_wait_time = 10

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers

  Capybara.register_driver :sauce do |app|
    capabilities = Sauce::Session.capybara_capabilities(platform)
    Capybara::Selenium::Driver.new(app, **capabilities)
  end

  config.before(:each) do |test|
    Capybara.current_driver = :sauce

    @session = Sauce::Session.new(generate_sauce_opts)
    @session.name = test.full_description
    @session.data_center = (ENV['SAUCE_DC'] || 'US_WEST').to_sym
    @session.start
  end

  config.after(:each) do |test|
    session_id = Capybara.current_session.driver.browser.session_id
    SauceWhisk::Jobs.change_status(session_id, !test.exception)
    Capybara.current_session.quit
  end

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
end
