require 'spec_helper'


describe User do
  #relationships
  before do
    @user2 = User.create(:name => 'fito', :email => 'biteprofile3@gmail.com', :password => 'letstest', :image_url => 'image/url')
    @user = User.create(:name => 'minoo', :email => 'biteprofile@gmail.com', :password => 'letstest', :image_url => 'image/url')
    @product = Product.create(:name => 'bread', :user_id => @user.id)
    @allergy = Allergy.create(:allergable_id => @user.id, :allergable_type => @user.class.name, :allergen => 'milk')
  end
  
  it "Should have an array of products" do
    @user.products.class.should == Array
  end
  
  it "Should have the right product" do
    @user.products.should include(@product)
  end
  
  it "Should have an array of allergies" do
    @user.allergies.class.should == Array
  end
  
  it "Shoudl have the right allergy" do
    @user.allergies.should include(@allergy)
  end  
  
  #attributes
  it "should have a name" do
    @user.name.should_not be_nil
  end
  
  it "should be saved if parameters are valid " do
    @user.new_record?.should == false
  end
  
  it "should have at least 3 characters" do
    @user.name.size.should >= 3
  end
  
  it 'should not be saved if name has less than 3 characters' do
    @user1 = User.create(:name => 'mo', :email => 'biteprofile2@gmail.com', :password => 'letstest')
    @user1.new_record?.should == true
  end
  
  it "should have the right name" do
    @user.name.should == 'minoo'
  end
  
  it "shoudl have an email" do
    @user.email.should_not be_nil
  end
  
  it "should be the right email" do
    @user.email.should == 'biteprofile@gmail.com'
  end
  
  it 'should check for allergy when passed and allergen' do
    @user.allergic_to?('milk').should == true
  end
  
  it 'should return false if not allergic' do
    @user.allergic_to?('nuts').should == false
  end
  
  it 'should never retrun nil when checking for allergen' do
    @user.allergic_to?('').should_not be_nil
  end
  
  it 'should have an image url' do
    @user.image_url.should_not be_nil
    @user.image_url.should == 'image/url'
  end
  
  describe "#add_allergies_from_allergens" do
    it "should create allergies" do
      @user2.add_allergies_from_allergens({:wheat => 1, :peanuts => 0})
      Allergy.find_by_allergen("wheat").should_not be_nil
    end
    
    it "should relate the newly created allergy to the user" do
      @user2.add_allergies_from_allergens({:tree_nuts => 1, :peanuts => 0})
      Allergy.find_by_allergen("tree_nuts").allergable_id.should == @user2.id
    end
    
    it "should save the allergies" do
      @user2.add_allergies_from_allergens({:pineapple => 1, :peanuts => 0})
      Allergy.find_by_allergen("pineapple").new_record?.should be_false
    end  
    
    it "should set allergies for the user" do
      @user2.add_allergies_from_allergens({:gluten => 1, :peanuts => 0})
      @user2.allergies.first.allergen.should == 'gluten'
    end
  end
end













