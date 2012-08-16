require 'spec_helper'

describe Product do
  before do
    @user = User.create(:name => 'minoo', :email => 'biteprofile@gmail.com', :password => 'letstest')
    4.times do
      @product = Product.create(:name => "bread_#{rand(10)}", :user_id => @user.id, :image_url => 'image/url', :store_name => 'Trader Joes')
    end
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
  
  describe "#retrieve_in_groups()" do
    before do
      @products_group = Product.retrieve_in_groups(2)
    end
    
    it "should return an array" do
      @products_group.class.should == Array
    end
    
    it "should return a collection of arrays" do
      @products_group.first.class.should == Array
    end
    
    it "should return a collection of arrays with the right size" do
      @products_group.first.size.should == 2
    end
  end
end






