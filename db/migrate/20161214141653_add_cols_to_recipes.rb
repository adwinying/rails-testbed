class AddColsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :name, :string
    add_column :recipes, :description, :text
    add_column :recipes, :user_id, :integer
  end
end
