Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Route for ingredient form page
  get "recipes/ingredient" => "recipes#ingredient", as: :recipe_ingredient
  post 'fetch_recipes', to: 'recipes#ingredient'
  # Route for dietary search
  get "recipes/dietary" => "recipes#dietary", as: :recipe_dietary
  post "fetch_dietary_recipes", to: "recipes#dietary"

   # Route for dietary search
   get "recipes/type" => "recipes#type", as: :recipe_type
   post "fetch_type_recipes", to: "recipes#type"

  # Routes for recipes
  resources :recipes, only: [:index, :show] do
    collection do
      post 'fetch_recipes', to: 'recipes#fetch_recipes', as: :fetch_recipes
    end
  end
end
