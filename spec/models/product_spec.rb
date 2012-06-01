require 'spec_helper'

describe Product do
  before do
    @user = User.create(:name => 'minoo', :email => 'biteprofile@gmail.com', :password => 'letstest')
    @product = Product.create(:name => 'bread', :user_id => @user.id)
  end
  
  #relationships
  it 'Should have an user' do
  @product.user.should == @user 
  end
  
  
  it 'Should have an array of allergies' do
   @product.allergies.class.should == Array 
  end
   
   
  #attributes
  it 'Should have a name' do
    @product.name.should_not be_nil
  end
end
