class Product < ActiveRecord::Base
  attr_accessible :name, :user_id, :image_url, :store_name
  belongs_to :user
  has_many :allergies, :as => :allergable
   
end
