require 'spec_helper'

describe Allergy do
  before do
     @user = User.create(:name => 'minoo', :email => 'biteprofile@gmail.com', :password => 'letstest')
     @product = Product.create(:name => 'bread', :user_id => @user.id)
     @allergy1 = Allergy.create(:allergable_id => @user.id, :allergable_type => @user.class.name)
     @allergy2 = Allergy.create(:allergable_id => @product.id, :allergable_type => @product.class.name)
   end

#relationships
   it "Should have an array of allergies" do
      @user.allergies.class.should == Array
   end
    
    
  it "Should belong to the right product or user" do
    @allergy1.allergable.should == @user
    @allergy2.allergable.should == @product
  end
  
  it "should be listed as an allergy for the right product or user" do
    @user.allergies.should include(@allergy1)
    @product.allergies.should include(@allergy2)
  end

end