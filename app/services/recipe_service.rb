class RecipeService
    def self.fetch_categories
        response = ThemealdbService.fetch_categories()

        if response[:status] == 200
            categories = response[:data]&.fetch('categories', [])

            { status: 200, data: categories }
        else
            { status: 500, message: 'An error occurred while fetching categories' }
        end
    end

    def self.filter_category(category)
        response = ThemealdbService.filter_category(category)

        if response[:status] == 200
            filter = response[:data]&.fetch('meals') || []

            { status: 200, data: filter }
        else
            { status: 500, message: 'An error occurred while filtering categories' }
        end
    end

    def self.lookup_recipe(id)
        response = ThemealdbService.lookup_recipe(id)

        if response[:status] == 200
            meals = response[:data]&.fetch('meals') || []
            recipe = meals.first

            if recipe
                { status: 200, data: recipe }
            else
                { status: 404, data: "Recipe #{id} not found"}
            end
        else
            { status: 500, message: 'An error occurred while getting recipe' }
        end
    end
end
