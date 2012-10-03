class HomeController < ApplicationController
  def index
  end
  
  def panel
    @products_from_bite_match = current_user.bite_match(4)
  end
  
  def bite_match
    @products_from_bite_match = current_user.bite_match(4)
  end
  
  def user_added
    @products_for_current_user = Product.retrieve_in_groups_for_user(current_user, 4)
  end
  
  def search_form
    @allergens =  [:milk, :eggs, :peanuts, :tree_nuts, :fish, :shellfish, :soy, :wheat]
  end
end
