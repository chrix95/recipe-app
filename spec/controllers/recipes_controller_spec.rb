require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  describe 'GET #index' do
    it 'renders a welcome message' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq('Welcome to Recipes API v1')
    end
  end

  describe 'GET #categories' do
    it 'renders categories from RecipeService' do
      allow(RecipeService).to receive(:fetch_categories).and_return(['category1', 'category2'])
      get :categories
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(['category1', 'category2'].to_json)
    end
  end

  describe 'GET #filter' do
    it 'renders filtered recipes from RecipeService' do
      allow(RecipeService).to receive(:filter_category).and_return(['recipe1', 'recipe2'])
      get :filter, params: { category: 'some_category' }
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(['recipe1', 'recipe2'].to_json)
    end
  end

  describe 'GET #lookup' do
    it 'renders a specific recipe from RecipeService' do
      allow(RecipeService).to receive(:lookup_recipe).and_return({ 'recipe' => 'recipe_details' })

      # Use a valid ID for the test
      get :lookup, params: { id: 'valid_id' }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({ 'recipe' => 'recipe_details' })
    end

    it 'renders not found for missing recipe from RecipeService' do
      allow(RecipeService).to receive(:lookup_recipe).and_return({ status: 404, data: 'Recipe 4353 not found' })
  
      # Use a non-existing ID for the test
      get :lookup, params: { id: 'non_existing_id' }
  
      expected_response = { 'data' => 'Recipe 4353 not found', 'status' => 404 }
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end
end