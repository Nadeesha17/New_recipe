class RecipesController < ApplicationController
  require 'httparty'


  def index
  end

  def show
    @recipe = Recipe.find(params[:id])
  end


    def ingredient
      if params[:ingredients].present?
        fetch_recipes
      end

    end

    class RecipesController < ApplicationController
      def dietary
        dietary_type = params[:dietary]

        if dietary_type.present?
          api_key = ENV["SPOONACULAR_API_KEY"]
          url = "https://api.spoonacular.com/recipes/complexSearch?diet=#{dietary_type}&apiKey=#{api_key}"
          response = HTTParty.get(url)

          if response.success?
            @recipes = response.parsed_response["results"]
          else
            flash[:alert] = "Error fetching dietary recipes: #{response.message} (Code: #{response.code})"
            @recipes = []
          end
        else
          @recipes = []
        end
      end
    end


    private


    def fetch_recipes
      ingredients = params[:ingredients]
      ingredients = ingredients.split(',').map(&:strip).join(',')

      Rails.logger.info "Ingredients: #{ingredients}"

      # Spoonacular API key
      api_key = ENV["SPOONACULAR_API_KEY"]
      url = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=#{ingredients}&apiKey=#{api_key}"

      # Get response from Spoonacular API
      response = HTTParty.get(url)

      Rails.logger.info "API Response: #{response.body}"

      if response.success?
        @recipes = response.parsed_response
        Rails.logger.info "Parsed Recipes: #{@recipes.inspect}"
      else
        flash[:alert] = "Error fetching recipes: #{response.message} (Code: #{response.code})"
        @recipes = []
      end
    end
  end


  class RecipesController < ApplicationController
    require 'httparty'

    def index
    end

    def show
      @recipe = Recipe.find(params[:id])
    end

    # Ingredient-based recipe search
    def ingredient
      if params[:ingredients].present?
        fetch_recipes
      else
        @recipes = []
      end
    end

    # Dietary-based recipe search
    def dietary
      dietary_type = params[:dietary]

      if dietary_type.present?
        api_key = ENV["SPOONACULAR_API_KEY"]
        url = "https://api.spoonacular.com/recipes/complexSearch?diet=#{dietary_type}&apiKey=#{api_key}"
        response = HTTParty.get(url)

        Rails.logger.info "API Request URL: #{url}"
        Rails.logger.info "API Response: #{response.body}"

        if response.success? && response.parsed_response["results"].present?
          @recipes = response.parsed_response["results"]
        else
          flash[:alert] = "No recipes found for #{dietary_type} or an error occurred."
          @recipes = []
        end
      else
        @recipes = []
      end
    end

    private

    def fetch_recipes
      ingredients = params[:ingredients].split(',').map(&:strip).join(',')
      api_key = ENV["SPOONACULAR_API_KEY"]
      url = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=#{ingredients}&apiKey=#{api_key}"
      response = HTTParty.get(url)

      Rails.logger.info "Fetching Recipes for Ingredients: #{ingredients}"
      Rails.logger.info "API Response: #{response.body}"

      if response.success?
        @recipes = response.parsed_response
      else
        flash[:alert] = "Error fetching recipes: #{response.message} (Code: #{response.code})"
        @recipes = []
      end
    end
  end




  