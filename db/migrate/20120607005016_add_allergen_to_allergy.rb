class AddAllergenToAllergy < ActiveRecord::Migration
  def change
    add_column :allergies, :allergen, :string
  end
end
