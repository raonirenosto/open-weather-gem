# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "open_weather_raoni"

require "minitest/autorun"

def load_api_response
  file_data = File.read("#{__dir__}/san_francisco_response.txt")
  puts JSON.parse(file_data)
end
