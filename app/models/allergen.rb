class Allergen < ActiveRecord::Base
  attr_accessible :name, :allergy_id
  belongs_to :allergy
end
