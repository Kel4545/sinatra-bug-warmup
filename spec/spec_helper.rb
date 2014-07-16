require "./app"
require "Capybara/rspec"
ENV["RACK_ENV"] = "test"

Capybara.app = App
