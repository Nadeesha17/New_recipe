class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :instructions, presence: true
end

