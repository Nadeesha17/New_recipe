class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :content, presence: true, unless: :rating?
  validates :rating, presence: true, inclusion: { in: 1..5 }, if: :rating?

  def self.average_rating_for_recipe(recipe)
    where(recipe: recipe).average(:rating).to_f
  end
end
