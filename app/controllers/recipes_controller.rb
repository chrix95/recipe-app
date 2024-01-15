class RecipesController < ApplicationController
    before_action :set_category_params, :set_recipe_id_params, only: [:filter, :lookup]

    def index
        categories = RecipeService.fetch_categories
        render json: { status: 200, message: "Welcome to Recipes API v1" }
    end

    def categories
        categories = RecipeService.fetch_categories
        render json: categories
    end

    def filter
        recipes = RecipeService.filter_category(@category)
        render json: recipes
    end

    def lookup
        recipe = RecipeService.lookup_recipe(@id)
        render json: recipe
    end

    private

    def set_category_params
        @category = params[:category]
    end

    private

    def set_recipe_id_params
        @id = params[:id]
    end
end
