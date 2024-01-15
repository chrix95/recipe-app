class RecipeService
    def self.fetch_categories
        response = ThemealdbService.fetch_categories()

        if response[:status] == 200
            categories = response[:data]&.fetch('categories', [])

            ResponseService.success_response(categories)
        else
            ResponseService.failure_response(500, "An error occurred while fetching categories")
        end
    end

    def self.filter_category(category)
        response = ThemealdbService.filter_category(category)

        if response[:status] == 200
            filter = response[:data]&.fetch('meals') || []

            ResponseService.success_response(filter)
        else
            ResponseService.failure_response(500, "An error occurred while filtering categories")
        end
    end

    def self.lookup_recipe(id)
        response = ThemealdbService.lookup_recipe(id)

        if response[:status] == 200
            meals = response[:data]&.fetch('meals') || []
            recipe = meals.first

            if recipe
                ResponseService.success_response(recipe)
            else
                ResponseService.failure_response(404, "Recipe #{id} not found")
            end
        else
            ResponseService.failure_response(500, "An error occurred while getting recipe")
        end
    end
end
