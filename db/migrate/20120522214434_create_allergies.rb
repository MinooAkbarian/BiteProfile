class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.integer :allergable_id
      t.string :allergable_type

      t.timestamps
    end
  end
end
