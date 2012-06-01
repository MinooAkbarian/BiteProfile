require 'spec_helper'

describe Allergen do
  before do
   @user = User.create(:name => 'minoo', :email => 'biteprofile@gmail.com', :password => 'letstest')
   @product = Product.create(:name => 'bread', :user_id => @user.id)
   @allergy1 = Allergy.create(:allergable_id => @user.id, :allergable_type => @user.class.name)
   @allergy2 = Allergy.create(:allergable_id => @product.id, :allergable_type => @product.class.name)
   @allergen1 = Allergen.create(:allergen_name => 'nuts')
   @allergen2 = Allergen.create(:allergen_name => 'milk')
  end

#relationships

  it "should belong to the right allergy" do
    @allergy1.allergen.should == 'nuts'
    @allergy2.allergen.should == 'milk'
  end

end
