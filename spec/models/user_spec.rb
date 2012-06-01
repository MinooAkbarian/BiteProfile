require 'spec_helper'


describe User do
  #relationships
  before do
    @user1 = User.create(:name => 'mo', :email => 'biteprofile2@gmail.com', :password => 'letstest')
    @user = User.create(:name => 'minoo', :email => 'biteprofile@gmail.com', :password => 'letstest')
    @product = Product.create(:name => 'bread', :user_id => @user.id)
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
end