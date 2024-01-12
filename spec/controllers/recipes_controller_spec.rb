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
    it 'renders categories' do
      allow(RecipeService).to receive(:fetch_categories).and_return(['category1', 'category2'])
      get :categories
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(['category1', 'category2'].to_json)
    end
  end

  describe 'GET #filter' do
    it 'renders filtered recipes' do
      allow(RecipeService).to receive(:filter_category).and_return(['recipe1', 'recipe2'])
      get :filter, params: { category: 'some_category' }
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(['recipe1', 'recipe2'].to_json)
    end
  end

  describe 'GET #lookup' do
    it 'renders a specific recipe' do
      allow(RecipeService).to receive(:lookup_recipe).and_return('recipe_details')
      get :lookup, params: { id: 'some_id' }
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq('recipe_details'.to_json)
    end
  end
end