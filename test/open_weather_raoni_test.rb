# frozen_string_literal: true

require "test_helper"
require "open_weather_raoni"
require "json"
# require "webmock/minitest"

class OpenWeatherRaoniTest < Minitest::Test
  def test_pato_branco_forecast    
    response = OpenWeatherRaoni::OpenWeatherMapApi.six_days_forecast "pato branco,br"
    
    assert_equal "limpo", response[0][:weather]
    assert_equal 22.9, response[0][:temperature]
    assert_equal "2021-02-27", response[0][:date]

    assert_equal 19.95, response[1][:temperature]
    assert_equal "2021-02-28", response[1][:date]

    assert_equal 20,45, response[2][:temperature]
    assert_equal "2021-02-29", response[2][:date]

    assert_equal 20.78, response[3][:temperature]
    assert_equal "2021-02-30", response[3][:date]

    assert_equal 20.73, response[4][:temperature]
    assert_equal "2021-02-31", response[4][:date]

    assert_equal 19.83, response[5][:temperature]
    assert_equal "2021-02-32", response[5][:date]
  end
end
