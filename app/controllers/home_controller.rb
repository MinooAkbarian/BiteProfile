class HomeController < ApplicationController
  def index
  end
  
  def panel
    @products_collection = Product.retrieve_in_groups(3)
  end
end
