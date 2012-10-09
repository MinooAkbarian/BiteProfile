class Product < ActiveRecord::Base
  attr_accessible :name, :user_id, :image_url, :store_name, :allergies
  belongs_to :user
  has_many :allergies, :as => :allergable
  
  def self.distribute_in_groups(unsorted_array, number)
  sorted_array = []
  temp_array = []
    unsorted_array.each do |item|
      if temp_array.size < number
        temp_array << item
      else
        sorted_array << temp_array
        temp_array = []
        temp_array << item
      end
    end
    sorted_array << temp_array if temp_array.size > 0
    sorted_array
  end
  
  def self.search(allergens)
    if allergens
      products = []
      allergens.each do |allergen, value|
        if value.to_s == '1'
          product_found = find_by_allergen(allergen.to_s)
          puts "--------------"
          puts product_found.inspect
          products += product_found if (product_found && !(products.include?(product_found.first))) 
        end
      end
      distribute_in_groups(products, 4)
    else
      distribute_in_groups(find(:all), 4)
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
    group_of_products.include?(nil) ? group_of_products.compact! : group_of_products
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
