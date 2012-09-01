class Product < ActiveRecord::Base
  attr_accessible :name, :user_id, :image_url, :store_name, :allergies
  belongs_to :user
  has_many :allergies, :as => :allergable
  
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
  
  def add_allergies_from_allergens(allergens)
    allergies = []
    allergens.each do |allergen, value|
      if value == 1
        allergies << Allergy.find_or_create_by_allergen(allergen.to_s)
      end
    end
    self.allergies = allergies
  end
end
