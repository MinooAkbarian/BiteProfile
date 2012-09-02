require 'spec_helper'

describe ProductsController do
  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  def valid_allergens
    { :wheat => 1, :fish => 0, :peanuts => 0 }
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all products as @products" do
      product = Product.create! valid_attributes
      get :index, {}, valid_session
      assigns(:products).should eq([product])
    end
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :show, {:id => product.to_param}, valid_session
      assigns(:product).should eq(product)
    end
  end

  describe "GET new" do
    it "assigns a new product as @product" do
      get :new, {}, valid_session
      assigns(:product).should be_a_new(Product)
    end
  end

  describe "GET edit" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :edit, {:id => product.to_param}, valid_session
      assigns(:product).should eq(product)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, {:product => valid_attributes, :allergies => valid_allergens}, valid_session
        }.to change(Product, :count).by(1)
      end
      
      it "creates new Allergies when allergens are passed" do
        expect {
          post :create, {:product => valid_attributes, :allergies => valid_allergens}, valid_session
        }.to change(Allergy, :count).by(1)
      end
      
      it "creates Allergies with the right parameters" do
        post :create, {:product => valid_attributes, :allergies => valid_allergens}, valid_session
        Allergy.last.allergable_id.should == Product.last.id
      end
      
      it "assigns a newly created product as @product" do
        post :create, {:product => valid_attributes, :allergies => valid_allergens}, valid_session
        assigns(:product).should be_a(Product)
        assigns(:product).should be_persisted
      end

      it "redirects to the created product" do
        post :create, {:product => valid_attributes, :allergies => valid_allergens}, valid_session
        response.should redirect_to(Product.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        # Trigger the behavior that occurs when invalid params are submitted
        Product.any_instance.stub(:save).and_return(false)
        post :create, {:product => {}, :allergies => valid_allergens}, valid_session
        assigns(:product).should be_a_new(Product)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Product.any_instance.stub(:save).and_return(false)
        post :create, {:product => {}, :allergies => valid_allergens}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested product" do
        product = Product.create! valid_attributes
        # Assuming there are no other products in the database, this
        # specifies that the Product created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Product.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => product.to_param, :product => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested product as @product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        assigns(:product).should eq(product)
      end

      it "redirects to the product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        response.should redirect_to(product)
      end
    end

    describe "with invalid params" do
      it "assigns the product as @product" do
        product = Product.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Product.any_instance.stub(:save).and_return(false)
        put :update, {:id => product.to_param, :product => {}}, valid_session
        assigns(:product).should eq(product)
      end

      it "re-renders the 'edit' template" do
        product = Product.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Product.any_instance.stub(:save).and_return(false)
        put :update, {:id => product.to_param, :product => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        delete :destroy, {:id => product.to_param}, valid_session
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      product = Product.create! valid_attributes
      delete :destroy, {:id => product.to_param}, valid_session
      response.should redirect_to(products_url)
    end
  end

end
