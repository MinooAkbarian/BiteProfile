class CreateAllergens < ActiveRecord::Migration
  def change
    create_table :allergens do |t|
      t.string :name

      t.timestamps
    end
  end
end
