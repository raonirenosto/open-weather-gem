require "test_helper"
require "open_weather_raoni/open_weather_map_api"
require "webmock/minitest"

class OpenWeatherRaoniTest < Minitest::Test

  def test_next_five_days_weather 
    @open_weather_api = OpenWeatherRaoni::OpenWeatherMapApi.new("any")
    url = "https://community-open-weather-map.p.rapidapi.com/forecast" +
        "?q=pato%20branco,BR&units=metric"
    stub_request(:get, url).to_return(body: load_five_days_response_sample)
    
    response = @open_weather_api.next_five_days_forecast "pato branco,BR"

    refute response[:error]

    assert_equal 19.95, response[:list][0][:temperature_average]
    assert_equal "2021-02-28", response[:list][0][:date]

    assert_equal 20.45, response[:list][1][:temperature_average]
    assert_equal "2021-03-01", response[:list][1][:date]

    assert_equal 20.78, response[:list][2][:temperature_average]
    assert_equal "2021-03-02", response[:list][2][:date]

    assert_equal 20.73, response[:list][3][:temperature_average]
    assert_equal "2021-03-03", response[:list][3][:date]

    assert_equal 19.83, response[:list][4][:temperature_average]
    assert_equal "2021-03-04", response[:list][4][:date]
  end

  def test_next_five_days_exception
    # Depending on the time, sometimes the current day will not be included 
    # in the requrest. This scenario is going to be tested as well.

    @open_weather_api = OpenWeatherRaoni::OpenWeatherMapApi.new("any")
    url = "https://community-open-weather-map.p.rapidapi.com/forecast" +
        "?q=pato%20branco,BR&units=metric"
    stub_request(:get, url).to_return(body: load_five_days_exception_sample)
    
    response = @open_weather_api.next_five_days_forecast "pato branco,BR"

    assert_equal 5, response[:list].size
  end

  def test_current_weather
    @open_weather_api = OpenWeatherRaoni::OpenWeatherMapApi.new("any")
    url = "https://community-open-weather-map.p.rapidapi.com/weather" +
        "?lang=pt_br&q=pato%20branco,BR&units=metric"
    stub_request(:get, url).to_return(body: load_current_weather_response_sample)
    
    response = @open_weather_api.current_weather "pato branco,BR"

    refute response[:error]
    assert_equal 23.44, response[:temperature]
    assert_equal "céu limpo", response[:weather]
  end

  def test_city_not_found_error
    @open_weather_api = OpenWeatherRaoni::OpenWeatherMapApi.new("any")

    stub_request(:get, /.*/)
      .to_return(status: 404, body: load_404_city_not_found_sample)
    
    response = @open_weather_api.current_weather "wrong name"

    assert_equal true, response[:error]
    assert_equal "city not found", response[:message]
  end

  def test_server_error
    @open_weather_api = OpenWeatherRaoni::OpenWeatherMapApi.new("any")

    stub_request(:get, /.*/)
      .to_return(status: 500, body: "")
    
    response = @open_weather_api.current_weather "any"

    assert_equal true, response[:error]
    assert_equal "Could not reach server", response[:message]
  end
end
