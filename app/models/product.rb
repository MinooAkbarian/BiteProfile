class Product < ActiveRecord::Base
  attr_accessible :name, :user_id
  belongs_to :user
  has_many :allergies, :as => :allergable
  
  
  # def self.find_products_with_allery_to_this_allergen(allergen)
  #   products_with_allergy_to_this_allergen_list = []
  #   allergies.each do |item|
  #       (products_with_allergy_to_this_allergen_list.push(item)) if (item.allergen.name == allergen)
  #     end
  #   return allergy_to_allergen_list
  #   end
  
end
