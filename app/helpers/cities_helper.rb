module CitiesHelper
  require 'httparty'
  API_URL = 'https://api.darksky.net/forecast/'
  API_TOKEN = 'da664bf04e33bd0443eea297e77848ac'

  def fetch_cities
    cities = Marshal.load($redis.get("cities")) if !$redis.get("cities").nil?
    if cities.nil?
      response = get_city
      errors = response[:errors]
      if errors.present?
        $redis.set("api.errors", (Marshal.dump(errors)))
      end
      cities = response[:cities]
      $redis.set("cities",Marshal.dump(cities))
      $redis.expire("cities",9.minutes.to_i)
    end
    {cities: cities}
  end

  def get_city
    @errors = []
    @cities = []
    city_response = ""
    data = Marshal.load($redis.get("data"))
    data.each do |city|
      begin
        city_url = "#{API_URL}#{API_TOKEN}/#{city[:latitude]},#{city[:longitude]}"
          response = HTTParty.get(
            city_url,
            { 
              headers:
                {
                  'Content-Type' => 'application/json; charset=utf-8',
                  'Accept' => 'application/json'
                }
            },
          ).body
        raise if rand(0.0...1.0) < 0.1
      rescue
        @errors.push({timestamp: Time.now,description:'How unfortunate! The API Request Failed'})
        retry
      end
      city_response = JSON.parse(response, symbolize_names: true) 
      country = city[:name]
      time = (Time.strptime("#{city_response[:currently][:time]}",'%S')).strftime("%H:%M:%S")
      temperature = city_response[:currently][:temperature]
      city_data = {country: country,time: time,temperature: temperature}
      @cities.push(city_data)
    end
    {cities: @cities,errors: @errors}
  end
end