class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy
  has_one_attached :image
  # serialize :ingredients, JSON
  validates :name, presence: true
  # validates :ingredients, presence: true, if: -> { ingredients.any? }

  validates :instructions, presence: true
end
