class RegistrationsController < Devise::RegistrationsController
  
  def new
     @allergens =  [:milk, :eggs, :peanuts, :tree_nuts, :fish, :shellfish, :soy, :wheat]
     super
  end
  
  
end
