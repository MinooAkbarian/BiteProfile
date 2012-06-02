class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :products
  has_many :allergies, :as => :allergable
  validates_presence_of :name
  validates_length_of :name, :minimum => 3
  validates_uniqueness_of :name, :email, :case_sensitive => false
  
  def allergic_to?(allergen)
    self.allergies.each do |allergy|
      (return true) if (allergy.allergen.name == allergen) 
    end
  end
end
