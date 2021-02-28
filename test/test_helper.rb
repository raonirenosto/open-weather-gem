# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "open_weather_raoni"
require "minitest/autorun"

def load_five_days_response_sample
  File.read("#{__dir__}/sample/five_days_response_sample.json")
end

def load_five_days_exception_sample
  File.read("#{__dir__}/sample/five_days_exception_sample.json")
end

def load_current_weather_response_sample
  File.read("#{__dir__}/sample/current_weather_sample.json")
end

def load_404_city_not_found_sample
  File.read("#{__dir__}/sample/404_city_not_found_sample.json")
end
