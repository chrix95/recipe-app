require 'httparty'

class ThemealdbService
    include HTTParty
    BASE_URL = 'https://www.themealdb.com/api/json/v1/1'.freeze
  
    def self.fetch_categories
        begin
            # Implement logic to fetch categories from Themealdb API
            # response = HTTParty.get("#{BASE_URL}/categories.php")
            # JSON.parse(response.body)
            response = HTTParty.get("#{BASE_URL}/categories.php")

            parsedResponse = JSON.parse(response.body)
            data = { status: 200, data: parsedResponse }
            # Return the data
            data
        rescue StandardError => e
            # Log the error message to a logger
            status_code = ActionDispatch::ExceptionWrapper.new(nil, e).status_code
            { status: status_code, message: "An error occurred: #{e.message}" }
        end
    end
  
    def self.filter_category(category)
        begin
            # Implement logic to filter categories from the Themealdb API
            # response = HTTParty.get("#{BASE_URL}/filter.php?c=#{category}")
            # JSON.parse(response.body)
            response = HTTParty.get("#{BASE_URL}/filter.php?c=#{category}")

            parsedResponse = JSON.parse(response.body)
            data = { status: 200, data: parsedResponse }
            # Return the data
            data
        rescue StandardError => e
            # Log the error message to a logger
            status_code = ActionDispatch::ExceptionWrapper.new(nil, e).status_code
            { status: status_code, message: "An error occurred: #{e.message}" }
        end
    end
  
    def self.lookup_recipe(id)
        begin
            # Implement logic to lookup a single recipe from the Themealdb API
            # response = HTTParty.get("#{BASE_URL}/lookup.php?i=#{id}")
            # JSON.parse(response.body)
            response = HTTParty.get("#{BASE_URL}/lookup.php?i=#{id}")

            parsedResponse = JSON.parse(response.body)
            data = { status: 200, data: parsedResponse }
            # Return the data
            data
        rescue StandardError => e
            # Log the error message to a logger
            status_code = ActionDispatch::ExceptionWrapper.new(nil, e).status_code
            { status: status_code, message: "An error occurred: #{e.message}" }
        end
    end
end