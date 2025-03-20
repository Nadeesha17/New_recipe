require 'net/http'
require 'json'
require 'dotenv/load'

class RecipesController < ApplicationController
  def index
    @recipes = fetch_recipes
  end

  def show
    @recipe = fetch_recipe(params[:id])
  end

  private
# Fetches a random set of 6 recipes from the API
  def fetch_recipes
    api_key = ENV['SPOONACULAR_API_KEY']
    url = "https://api.spoonacular.com/recipes/random?number=6&apiKey=#{api_key}"

    response = Net::HTTP.get(URI(url))
    data = JSON.parse(response)

    puts "API Response: #{data.inspect}"

    data["recipes"] || []
  end

#Fetches detailed information for a specific recipe based on its recipe_id.
  def fetch_recipe(recipe_id)
    api_key = ENV['SPOONACULAR_API_KEY']
    url = "https://api.spoonacular.com/recipes/#{recipe_id}/information?apiKey=#{api_key}"

    response = Net::HTTP.get(URI(url))
    JSON.parse(response) || {}
  end
end
