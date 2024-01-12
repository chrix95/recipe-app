require 'rails_helper'
require 'json'

RSpec.describe ThemealdbService, type: :service do
  describe '.fetch_categories' do
    it 'returns categories from Themealdb API' do
      # Stub the HTTP request and response
      allow(Net::HTTP).to receive(:get).and_return(load_fixture('categories_response.json'))

      result = ThemealdbService.fetch_categories

      expect(result[:status]).to eq(200)
      expect(result[:data]['categories']).to be_an(Array)
    end

    it 'handles errors and returns error message' do
      # Stub the HTTP request to raise an error
      allow(Net::HTTP).to receive(:get).and_raise(StandardError.new('Network error'))

      result = ThemealdbService.fetch_categories

      expect(result[:status]).to eq(500)
      expect(result[:message]).to eq('An error occurred: Network error')
    end
  end

  describe '.filter_category' do
    it 'returns filtered categories from Themealdb API' do
      # Stub the HTTP request and response
      allow(Net::HTTP).to receive(:get).and_return(load_fixture('filtered_categories_response.json'))

      result = ThemealdbService.filter_category('Chicken')

      expect(result[:status]).to eq(200)
      expect(result[:data]['meals']).to be_an(Array)
    end

    it 'handles errors and returns error message' do
      # Stub the HTTP request to raise an error
      allow(Net::HTTP).to receive(:get).and_raise(StandardError.new('Network error'))

      result = ThemealdbService.filter_category('InvalidCategory')

      expect(result[:status]).to eq(500)
      expect(result[:message]).to eq('An error occurred: Network error')
    end
  end

  describe '.lookup_recipe' do
    it 'returns a single recipe from Themealdb API' do
      # Stub the HTTP request and response
      allow(Net::HTTP).to receive(:get).and_return(load_fixture('lookup_recipe_response.json'))

      result = ThemealdbService.lookup_recipe('12345')

      expect(result[:status]).to eq(200)
      expect(result[:data]['meals']).to be_an(Array)
    end

    it 'handles errors and returns error message' do
      # Stub the HTTP request to raise an error
      allow(Net::HTTP).to receive(:get).and_raise(StandardError.new('Network error'))

      result = ThemealdbService.lookup_recipe('InvalidID')

      expect(result[:status]).to eq(500)
      expect(result[:message]).to eq('An error occurred: Network error')
    end
  end

  # Helper method to load fixture files
  def load_fixture(filename)
    File.read(Rails.root.join('spec', 'fixtures', filename))
  end
end