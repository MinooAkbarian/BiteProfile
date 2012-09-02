require 'spec_helper'

describe Product do
  before do
    @user = User.create(:name => 'minoo', :email => 'biteprofile@gmail.com', :password => 'letstest')
    4.times do
      @product = Product.create(:name => "bread_#{rand(10)}", :user_id => @user.id, :image_url => 'image/url', :store_name => 'Trader Joes')
    end
    @product_1 = Product.create(:name => "bread_#{rand(10)}", :user_id => @user.id, :image_url => 'image/url', :store_name => 'Trader Joes')
    @allergy = Allergy.create(:allergen => 'fish', :allergable_id => @product.id, :allergable_type => @product.class.name)
  end
  
  #relationships
  it 'Should have an user' do
  @product.user.should == @user 
  end
  
  
  it 'Should have an array of allergies' do
   @product.allergies.class.should == Array 
  end
  
  it 'should have the right allergies' do
    @product.allergies.should include(@allergy)
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
    
    it "should return an array of arrays" do
      @products_group.class.should == Array
      @products_group.first.class.should == Array
    end
    
    it "should return a collection of arrays with the right size" do
      @products_group.first.size.should == 2
    end
    
    it "should return a collection of products" do
      @products_group.first.first.class.should == Product
    end
  end  
  
  describe "#retrieve_in_groups_for_user()" do
    before do
      @user_products_group = Product.retrieve_in_groups_for_user(@user, 2)
    end
    it "should return an array of arrays" do
      @user_products_group.class.should == Array
      @user_products_group.first.class.should == Array
    end
    
    it "should return a collection of products" do
      @user_products_group.first.first.class.should == Product
    end
    
    it "should return the right products" do
      retrieved_product = @user_products_group.first.first
      @user.products.should include(retrieved_product)
    end
  end
  
  describe "#add_allergies_from_allergens" do
    it "should create allergies" do
      @product_1.add_allergies_from_allergens({:wheat => 1, :peanuts => 0})
      Allergy.find_by_allergen("wheat").should_not be_nil
    end
    
    it "should relate the newly created allergy to the product" do
      @product_1.add_allergies_from_allergens({:tree_nuts => 1, :peanuts => 0})
      Allergy.find_by_allergen("tree_nuts").allergable_id.should == @product_1.id
    end
    
    it "should save the allergies" do
      @product_1.add_allergies_from_allergens({:pineapple => 1, :peanuts => 0})
      Allergy.find_by_allergen("pineapple").new_record?.should be_false
    end  
    
    it "should set allergies for the product" do
      @product_1.add_allergies_from_allergens({:gluten => 1, :peanuts => 0})
      @product_1.allergies.first.allergen.should == 'gluten'
    end
  end
end






