require 'spec_helper'

describe Product do
  before do
    @user = User.create(:name => 'minoo', :email => 'biteprofile@gmail.com', :password => 'letstest')
    @product = Product.create(:name => 'bread', :user_id => @user.id, :image_url => 'image/url', :store_name => 'Trader Joes')
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
  
  it 'Should have an image URL' do
    @product.image_url.should_not be_nil
    @product.image_url.should == 'image/url'
  end
  
  it 'Should have a store name' do
     @product.store_name.should_not be_nil
     @product.store_name.should == 'Trader Joes'
  end
end
