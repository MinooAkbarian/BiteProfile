class CreateAllergens < ActiveRecord::Migration
  def change
    create_table :allergens do |t|
      t.string :allergen_name

      t.timestamps
    end
  end
end
