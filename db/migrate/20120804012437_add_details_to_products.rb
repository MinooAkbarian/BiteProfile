class AddDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :image_url, :string
    add_column :products, :store_name, :string
  end
end
