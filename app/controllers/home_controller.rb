class HomeController < ApplicationController
  def index
  end
  
  def panel
    @products_for_current_user = Product.retrieve_in_groups_for_user(current_user, 4)
  end
end
