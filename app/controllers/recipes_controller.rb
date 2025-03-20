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


    def type
      meal_type = params[:type]

      if meal_type.present?
        api_key = ENV["SPOONACULAR_API_KEY"]
        url = "https://api.spoonacular.com/recipes/complexSearch?type=#{meal_type}&apiKey=#{api_key}"
        response = HTTParty.get(url)

        Rails.logger.info "API Request URL: #{url}"
        Rails.logger.info "API Response: #{response.body}"

        if response.success? && response.parsed_response["results"].present?
          @recipes = response.parsed_response["results"]
        else
          flash[:alert] = "No recipes found for meal type: #{meal_type} or an error occurred."
          @recipes = []
        end
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
  end
