class Allergy < ActiveRecord::Base
  attr_accessible :allergable_id, :allergable_type
  belongs_to :allergable, :polymorphic => true
  has_one :allergen
  #validate_presence_of :allergen
  
  def self.find_from_allergen(array, allergen)
  allergy_to_allergen_list = []
    array.each do |item|
      (allergy_to_allergen_list.push(item)) if (item.allergen.name == allergen)
    end
  return allergy_to_allergen_list
  end
end

