require 'spec_helper'


describe User do
  #relationships
  before do
    @user = User.create(:name => 'Minoo', :email => 'biteprofile@gmail.com', :password => 'letstest')
    @product = Product.create(:name => 'bread', :user_id => @user.id)
  end
  
  it "Should have an array of products" do
    @user.products.class.should == Array
  end
  
  it "Should have the right product" do
    @user.products.should include(@product)
  end
  
  
  #attributes
  it "needs a name" do
    @user.name.should == 'Minoo'
  end
  
  it "needs an email"
end