class Allergen < ActiveRecord::Base
  attr_accessible :name
  belongs_to :allergy
end
