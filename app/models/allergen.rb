class Allergen < ActiveRecord::Base
  attr_accessible :allergen_name
  belongs_to :allergy
end
