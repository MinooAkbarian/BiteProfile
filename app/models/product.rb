class Product < ActiveRecord::Base
  attr_accessible :name, :user_id, :image_url, :store_name, :allergies
  belongs_to :user
  has_many :allergies, :as => :allergable
  
  def self.search(allergens)
    if allergens
      products = []
      allergens.each do |allergen, value|
        if value.to_s == '1'
          product_found = find_by_allergen(allergen.to_s)
          products += product_found if product_found
        end
      end
      products
    else
      find(:all)
    end
  end
  
  def self.retrieve_in_groups(batch_size)
    group_of_batches = []
    self.find_in_batches(:batch_size => batch_size) do |batch|
      group_of_batches << batch
    end
    group_of_batches
  end
  
  def self.retrieve_in_groups_for_user(user, batch_size)
    group_of_batches = []
    self.where("user_id = ?", user.id).find_in_batches(:batch_size => batch_size) do |batch|
      group_of_batches << batch
    end
    group_of_batches
  end

  def self.find_by_allergen(allergen)
    group_of_products = []
    Allergy.where("allergen = ? AND allergable_type = ?", allergen, 'Product').all.each do |allergy|
      group_of_products << allergy.allergable
    end    
    group_of_products.compact!
  end
  
  def add_allergies_from_allergens(allergens)
    if allergens != nil
      allergens.each do |allergen, value|
        if value.to_s == '1'
          Allergy.create(:allergen => allergen.to_s, :allergable_id => self.id, :allergable_type => 'Product')
        end
      end
    end
  end
end
