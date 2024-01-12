class RecipeService
    def self.fetch_categories
        response = ThemealdbService.fetch_categories()

        if response[:status] == 200
            categories = response[:data]&.fetch('categories', [])

            { status: 200, data: categories }
        else
            { status: 500, message: 'An error occurred fetching categories'}
        end
    end
  
    def self.filter_category(category)
        response = ThemealdbService.filter_category(category)

        if response[:status] == 200
            filter = response[:data]&.fetch('meals') || []

            { status: 200, data: filter }
        else
            { status: 500, message: 'An error occurred filtering categories'}
        end
    end
  
    def self.lookup_recipe(id)
        response = ThemealdbService.lookup_recipe(id)

        if response[:status] == 200
            meals = response[:data]&.fetch('meals') || []
            recipe = meals.first&.to_h || {}

            { status: 200, data: recipe }
        else
            { status: 500, message: 'An error occurred getting recipe'}
        end
    end
end