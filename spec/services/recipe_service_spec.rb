require 'rails_helper'

RSpec.describe RecipeService, type: :service do
  describe '.fetch_categories' do
    it 'returns categories from ThemealdbService' do
      # Stub ThemealdbService.fetch_categories to return a sample response
      allow(ThemealdbService).to receive(:fetch_categories).and_return(status: 200, data: { 'categories' => ['category1', 'category2'] })

      result = RecipeService.fetch_categories

      expect(result).to eq(status: 200, data: ['category1', 'category2'])
    end

    it 'handles error and returns error message' do
      # Stub ThemealdbService.fetch_categories to raise an error
      allow(ThemealdbService).to receive(:fetch_categories).and_return(status: 500, message: 'An error occurred fetching categories')

      result = RecipeService.fetch_categories

      expect(result).to eq(status: 500, message: 'An error occurred fetching categories')
    end
  end

  describe '.filter_category' do
    it 'returns filtered categories from ThemealdbService' do
      # Stub ThemealdbService.filter_category to return a sample response
      allow(ThemealdbService).to receive(:filter_category).and_return(status: 200, data: { 'meals' => ['meal1', 'meal2'] })

      result = RecipeService.filter_category('Chicken')

      expect(result).to eq(status: 200, data: ['meal1', 'meal2'])
    end

    it 'handles error and returns error message' do
      # Stub ThemealdbService.filter_category to raise an error
      allow(ThemealdbService).to receive(:filter_category).and_return(status: 500, message: 'An error occurred filtering categories')

      result = RecipeService.filter_category('InvalidCategory')

      expect(result).to eq(status: 500, message: 'An error occurred filtering categories')
    end
  end

  describe '.lookup_recipe' do
    it 'returns a specific recipe from ThemealdbService' do
      # Stub ThemealdbService.lookup_recipe to return a sample response
      allow(ThemealdbService).to receive(:lookup_recipe).and_return(status: 200, data: { 'meals' => [{ 'recipe' => 'details' }] })

      result = RecipeService.lookup_recipe('12345')

      expect(result).to eq(status: 200, data: { 'recipe' => 'details' })
    end

    it 'handles not found and returns error message' do
      # Stub ThemealdbService.lookup_recipe to return an empty response
      allow(ThemealdbService).to receive(:lookup_recipe).and_return(status: 200, data: { 'meals' => [] })

      result = RecipeService.lookup_recipe('InvalidID')

      expect(result).to eq(status: 404, data: 'Recipe InvalidID not found')
    end

    it 'handles error and returns error message' do
      # Stub ThemealdbService.lookup_recipe to raise an error
      allow(ThemealdbService).to receive(:lookup_recipe).and_return(status: 500, message: 'An error occurred getting recipe')

      result = RecipeService.lookup_recipe('InvalidID')

      expect(result).to eq(status: 500, message: 'An error occurred getting recipe')
    end
  end
end
