class Allergy < ActiveRecord::Base
  attr_accessible :allergable_id, :allergable_type, :allergen
  belongs_to :allergable, :polymorphic => true
  validates_presence_of :allergen
  validates_uniqueness_of :allergen
end

