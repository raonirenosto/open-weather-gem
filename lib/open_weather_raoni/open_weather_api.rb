require 'uri'
require 'net/http'
require 'openssl'

module OpenWeatherRaoni
  class OpenWeatherMapApi
    def self.five_days_forecast city      
      url = URI("https://community-open-weather-map.p.rapidapi.com/forecast?q=pato%20branco%2Cbr&units=metric")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = '8471d368a6msh06ecefac78e33c6p1911c7jsna16db5043f30'
      request["x-rapidapi-host"] = 'community-open-weather-map.p.rapidapi.com'
      
      response = http.request(request)
      puts response.read_body
    end
  end
end