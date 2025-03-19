class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :ingredients
      t.text :instructions
      t.string :meal_type
      t.string :cuisine
      t.string :cooking_method
      t.string :dietary_restrictions

      t.timestamps
    end
  end
end
