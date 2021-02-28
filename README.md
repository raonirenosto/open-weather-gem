# OpenWeatherRaoni

This gem has two features:
- Retrieve the current forecast for a given city
- Retrieve the next 5 days forecast for a given city.

This gem uses the Open Weather Map API (https://openweathermap.org)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'open_weather_raoni'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install open_weather_raoni

## Usage

```ruby
require "open_weather_raoni/open_weather_map_api"
```

```ruby
open_weather_api = OpenWeatherRaoni::OpenWeatherMapApi.new #your_open_weather_map_key
```

Get a city current weather:
```ruby
forecast = open_weather_api.current_weather "pato branco,BR"

puts forecast[:temperature]
puts forecast[:weather]
```

Get a city next 5 days forecast:
```ruby
result = open_weather_api.next_five_days_forecast "pato branco,BR"

result[:list].each do |forecast|
    puts forecast[:temperature_average]
    puts forecast[:date]
end
```

Handling API errors:
```ruby
if result[:error]
    puts result[:message]
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/raonirenosto/open_weather_raoni.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
