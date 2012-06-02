class AddAllergyIdToAllergens < ActiveRecord::Migration
  def change
    add_column :allergens, :allergy_id, :integer
  end
end
