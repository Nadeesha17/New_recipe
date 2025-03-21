class RecipesController < ApplicationController
  require 'httparty'


  def index
    api_key = ENV["SPOONACULAR_API_KEY"]
    url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=#{api_key}"
    response = HTTParty.get(url)

    if response.success?
      @recipes = response.parsed_response["results"]
    else
      flash[:alert] = "Error fetching recipes: #{response.message}"
      @recipes = []
    end
  end

  def show
    recipe_id = params[:id]

    api_key = ENV["SPOONACULAR_API_KEY"]
    url = "https://api.spoonacular.com/recipes/#{recipe_id}/information?apiKey=#{api_key}"
    response = HTTParty.get(url)
    if response.success?
      @recipe = response.parsed_response
    else
      flash[:alert] = "Error fetching recipe details: #{response.message} (Code: #{response.code})"
      @recipe = {}
    end
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
      def cuisine
        cuisine_type = params[:cuisine]

        if cuisine_type.present?
          api_key = ENV["SPOONACULAR_API_KEY"]
          url = "https://api.spoonacular.com/recipes/complexSearch?cuisine=#{cuisine_type}&apiKey=#{api_key}"
          response = HTTParty.get(url)

          if response.success?
            @recipes = response.parsed_response["results"]
          else
            flash[:alert] = "Error fetching cuisine recipes: #{response.message} (Code: #{response.code})"
            @recipes = []
          end
        else
          @recipes = []
        end
      end

      def cooking
        cooking_methods = params[:cooking].to_s.downcase.split(",").map(&:strip)  # Get user input and clean it up

        if cooking_methods.any?
          api_key = ENV["SPOONACULAR_API_KEY"]
          url = "https://api.spoonacular.com/recipes/complexSearch?instructionsRequired=true&apiKey=#{api_key}"
          response = HTTParty.get(url)

          if response.success?
            # Filter recipes based on cooking methods in instructions
            @recipes = response.parsed_response["results"].select do |recipe|
              instructions_url = "https://api.spoonacular.com/recipes/#{recipe['id']}/analyzedInstructions?apiKey=#{api_key}"
              instructions_response = HTTParty.get(instructions_url)

              if instructions_response.success?
                steps = instructions_response.parsed_response.flat_map { |instruction| instruction['steps'].map { |step| step['step'].downcase } }
                cooking_methods.any? { |method| steps.any? { |step| step.include?(method) } }
              else
                false
              end
            end
          else
            flash[:alert] = "Error fetching recipes: #{response.message}"
            @recipes = []
          end
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
