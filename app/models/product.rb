class Product < ActiveRecord::Base
  attr_accessible :name, :user_id, :image_url, :store_name
  belongs_to :user
  has_many :allergies, :as => :allergable
  
  def self.retrieve_in_groups(batch_size)
    group_of_batches = []
    self.find_in_batches(:batch_size => batch_size) do |batch|
      group_of_batches << batch
    end
    group_of_batches
  end
end
