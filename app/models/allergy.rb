class Allergy < ActiveRecord::Base
  attr_accessible :allergable_id, :allergable_type
  belongs_to :allergable, :polymorphic => true
  has_one :allergen
  
  def self.find_from_allergen(array, allergen)
    
  end
end
