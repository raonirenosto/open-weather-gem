# frozen_string_literal: true

require_relative "open_weather_raoni/version"
require "open_weather_raoni/open_weather_map_api"

module OpenWeatherRaoni
  class OpenWeatherApiError < StandardError; 
    def initialize(message)
      super(message)
    end
  end
end
