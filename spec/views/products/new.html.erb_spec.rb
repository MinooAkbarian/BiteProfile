require 'spec_helper'

describe "products/new" do
  before(:each) do
    assign(:product, stub_model(Product,
      :name => "MyString"
    ).as_new_record)
    @allergens = [:milk, :fish, :peanuts]
  end

  it "renders new product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => products_path, :method => "post" do
      assert_select "input#product_name", :name => "product[name]"
    end
  end
end
