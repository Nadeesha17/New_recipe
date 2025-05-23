Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

# Define a route for the recipes index page
#get 'recipes', to: 'recipes#index', as: :recipe



  # Route for ingredient form page
  get "recipes/ingredient" => "recipes#ingredient", as: :recipe_ingredient
  post 'fetch_recipes', to: 'recipes#ingredient'
  # Route for dietary search
  get "recipes/dietary" => "recipes#dietary", as: :recipe_dietary
  post "fetch_dietary_recipes", to: "recipes#dietary"

  # Route for cuisine search
  get "recipes/cuisine" => "recipes#cuisine", as: :recipe_cuisine
  post "fetch_cuisine_recipes", to: "recipes#cuisine"

   # Route for type search
   get "recipes/type" => "recipes#type", as: :recipe_type
   post "fetch_type_recipes", to: "recipes#type"

   # Route for cooking search
  get "recipes/cooking" => "recipes#cooking", as: :recipe_cooking
  post "fetch_cooking_recipes", to: "recipes#cooking"


  # Routes for recipes
  resources :recipes, only: [:index, :show, :new, :create] do
    collection do
      post 'fetch_recipes', to: 'recipes#fetch_recipes', as: :fetch_recipes
      get 'added_recipes', to: 'recipes#added_recipes', as: :added_recipes

    end
    resources :comments, only: [:create] do
      # Route to handle ratings on the comments
      post 'ratings', to: 'comments#create_rating', as: :create_rating
    end
  end
end
