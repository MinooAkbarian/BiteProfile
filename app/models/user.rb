class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :image_url
  # attr_accessible :title, :body
  
  has_many :products
  has_many :allergies, :as => :allergable
  validates_presence_of :name
  validates_length_of :name, :minimum => 3
  validates_uniqueness_of :name, :email, :case_sensitive => false
  
  def allergic_to?(allergen)
    (find_allergy_from_allergen(self.allergies, allergen).size > 0)
  end
    
  def find_allergy_from_allergen(array, allergen)
    allergy_to_allergen_list = []
      array.each do |item|
        (allergy_to_allergen_list.push(item)) if (item.allergen == allergen)
      end
    return allergy_to_allergen_list
  end
  
  def add_allergies_from_allergens(allergens)
    if allergens != nil
      allergens.each do |allergen, value|
        if value.to_s == '1'
          Allergy.create(:allergen => allergen.to_s, :allergable_id => self.id, :allergable_type => 'User')
        end
      end
    end
  end
  
  def bite_match(number)
    matches = []
    self.allergies.each do |allergy|
      found_allergy = Product.find_by_allergen(allergy.allergen)
      (matches += found_allergy) if found_allergy != nil
    end
    distribute_in_groups(matches, number)
  end
  
  def distribute_in_groups(unsorted_array, number)
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
end
