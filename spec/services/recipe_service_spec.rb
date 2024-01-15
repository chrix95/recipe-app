require 'rails_helper'

RSpec.describe RecipeService, type: :service do
  describe '.fetch_categories' do
    it 'returns success response with categories when API call is successful' do
      allow(ThemealdbService).to receive(:fetch_categories).and_return(status: 200, data: { 'categories' => ['category1', 'category2'] })

      result = RecipeService.fetch_categories

      expect(result).to eq(
        status: 200,
        data: ['category1', 'category2'],
        meta: { timestamp: Time.now.utc.iso8601 }
      )
    end

    it 'returns failure response when API call fails' do
      allow(ThemealdbService).to receive(:fetch_categories).and_return(status: 500, message: 'Error')

      result = RecipeService.fetch_categories

      expect(result).to eq(
        status: 500,
        error: {
          code: 'INTERNAL_SERVER_ERROR',
          message: 'An error occurred while fetching categories',
          details: {}
        },
        meta: { timestamp: Time.now.utc.iso8601 }
      )
    end
  end

  describe '.filter_category' do
    it 'returns success response with filtered categories when API call is successful' do
      allow(ThemealdbService).to receive(:filter_category).and_return(status: 200, data: { 'meals' => ['recipe1', 'recipe2'] })

      result = RecipeService.filter_category('some_category')

      expect(result).to eq(
        status: 200,
        data: ['recipe1', 'recipe2'],
        meta: { timestamp: Time.now.utc.iso8601 }
      )
    end

    it 'returns success response with empty array when API call is successful but no meals found' do
      allow(ThemealdbService).to receive(:filter_category).and_return(status: 200, data: { 'meals' => nil })

      result = RecipeService.filter_category('some_category')

      expect(result).to eq(
        status: 200,
        data: [],
        meta: { timestamp: Time.now.utc.iso8601 }
      )
    end

    it 'returns failure response when API call fails' do
      allow(ThemealdbService).to receive(:filter_category).and_return(status: 500, message: 'Error')

      result = RecipeService.filter_category('some_category')

      expect(result).to eq(
        status: 500,
        error: {
          code: 'INTERNAL_SERVER_ERROR',
          message: 'An error occurred while filtering categories',
          details: {}
        },
        meta: { timestamp: Time.now.utc.iso8601 }
      )
    end
  end

  describe '.lookup_recipe' do
    it 'returns success response with recipe when API call is successful' do
      allow(ThemealdbService).to receive(:lookup_recipe).and_return(status: 200, data: { 'meals' => [{ 'recipe' => 'details' }] })

      result = RecipeService.lookup_recipe('valid_id')

      expect(result).to eq(
        status: 200,
        data: { 'recipe' => 'details' },
        meta: { timestamp: Time.now.utc.iso8601 }
      )
    end

    it 'returns failure response when API call is successful but no meals found' do
      allow(ThemealdbService).to receive(:lookup_recipe).and_return(status: 200, data: { 'meals' => nil })

      result = RecipeService.lookup_recipe('non_existing_id')

      expect(result).to eq(
        status: 404,
        error: {
          code: 'NOT_FOUND',
          message: 'Recipe non_existing_id not found',
          details: {}
        },
        meta: { timestamp: Time.now.utc.iso8601 }
      )
    end

    it 'returns failure response when API call fails' do
      allow(ThemealdbService).to receive(:lookup_recipe).and_return(status: 500, message: 'Error')

      result = RecipeService.lookup_recipe('some_id')

      expect(result).to eq(
        status: 500,
        error: {
          code: 'INTERNAL_SERVER_ERROR',
          message: 'An error occurred while getting recipe',
          details: {}
        },
        meta: { timestamp: Time.now.utc.iso8601 }
      )
    end
  end
end
