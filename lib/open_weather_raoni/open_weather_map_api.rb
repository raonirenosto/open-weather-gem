require 'uri'
require 'net/http'
require 'openssl'
require "json"

module OpenWeatherRaoni
  class OpenWeatherMapApi

    def initialize key
      @api_key = key
      @api_link = "https://community-open-weather-map.p.rapidapi.com"
    end

    def next_five_days_forecast city 
      response = ""
      begin
        response = api_five_day_weather city
      rescue OpenWeatherApiError => e
        e.inspect
        return {
          error => true,
          message => e.message
        }
      end
      forecasts = response["list"]
      parse_five_days_result forecasts
    end

    def current_weather city
      response = ""
      begin
        response = api_current_weather city
      rescue OpenWeatherApiError => e
        return {
          :error => true,
          :message => e.message
        }
      end
      parse_current_weather response
    end

    def api_current_weather city
      endpoint = "/weather"
      city_param = "?q=#{city}"
      unit_param = "&units=metric"
      language = "&lang=pt_br"
      composed_url = @api_link + endpoint + city_param + unit_param + language

      call_open_weather_api composed_url
    end

    def api_five_day_weather city
      endpoint = "/forecast"
      city_param = "?q=#{city}"
      unit_param = "&units=metric"
      composed_url = @api_link + endpoint + city_param + unit_param

      call_open_weather_api composed_url
    end

    def call_open_weather_api composed_url
      url = URI(composed_url)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = @api_key
      request["x-rapidapi-host"] = 'community-open-weather-map.p.rapidapi.com'
      
      response = http.request(request)

      body = ""
      if response.code != "500"
        body = JSON.parse(response.read_body)
        if response.code != "200"
          raise OpenWeatherApiError.new body["message"]
        end
      else
        raise OpenWeatherApiError.new "Could not reach server"
      end
  
      return body
    end

   
    def parse_current_weather response
      return {
        :error => false,
        :temperature => response["main"]["temp"],
        :weather => response["weather"][0]["description"]
      }
    end

    def parse_five_days_result list
      forecasts = []

      grouped_list =  list.group_by { |g| g["dt_txt"].split[0] }
      
      # ignore today
      if (grouped_list.size > 5)
        grouped_list.shift
      end
      
      grouped_list.each do |date, list|
        temperature_average = calculate_temperature_average list
        forecast_hash = {
          :temperature_average => temperature_average,
          :date => date
        }
        forecasts << forecast_hash
      end

      response = {
        :error => false,
        :list => forecasts
      }

      return response
    end

    def calculate_temperature_average list
      temperature_sum = list.sum {|item| item["main"]["temp"]}
      return (temperature_sum / list.size).floor(2)
    end
  end
end