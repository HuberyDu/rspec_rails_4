require "spec_helper"

describe ContactsController do
  describe "user access" do
  	before :each do
  	  user = create(:admin)
  	  session[:user_id] = user.id 
  	end

	  describe "GET #index" do
	  	context "with params[:letter]" do 
	  	  it "populates an array of contacts string with letter" do
	  	  	contact01 = create(:contact, lastname: "du")
	  	  	contact02 = create(:contact, lastname: "du")
	  	  	get :index, letter: "d"
	  	  	expect(assigns(:contacts)).to match_array([contact01,contact02])
	  	  end
	  	  it "renders the:index view" do
	  	  	get :index, letter: "d"
	  	  	expect(response).to render_template :index
	  	  end
	  	end

	  	context "without params[:letter]" do
	  	  it "populates an array of all contacts" do
	        contact01 = create(:contact, lastname: "du")
	  	  	get :index
	  	  	expect(assigns(:contacts)).to match_array([contact01])
	  	  end
	  	  it "renders the:index view" do
	  	  	get :index
	  	  	expect(response).to render_template :index
	  	  end
	  	end
	  end

	  describe "GET #show" do
	    it "assigns the requested contact to @contact" do
	  	  contact = create(:contact)
	  	  get :show, id: contact
	  	  expect(assigns(:contact)).to eq contact
	    end
	    it "renders the:show view" do
	      contact = create(:contact)
	  	  get :show, id: contact
	  	  expect(response).to render_template :show
	    end
	  end

	  describe "GET #new" do
	  	it "assigns the requested contact to @contact" do
	  	  contact = build(:contact)
	  	  get :new
	  	  expect(assigns(:contact)).to be_a_new(Contact)
	  	end
	  	it "renders the:new template" do
	  	  contact = build(:contact)
	  	  get :new
	  	  expect(response).to render_template :new
	  	end
	  end

	  describe "GET #edit" do
	  	it "assigns the requested contact to @contact" do
	      contact01 = create(:contact, lastname: "du")
	      get :edit, id: contact01
	      expect(assigns(:contact)).to eq contact01
	  	end
	  	it "renders the:edit template" do
	  	  contact01 = create(:contact, lastname: "du")
	  	  get :edit, id: contact01
	  	  expect(response).to render_template :edit
	  	end
	  end

	  describe "POST #create" do
	  	before :each do
	  	  @phones = [
	  	  	attributes_for(:phone),
	  	  	attributes_for(:phone),
	  	  	attributes_for(:phone)
	  	  ]
	  	end

	    context "with valid attributes" do
	      it "save the new contact in database" do
	      	expect{post :create, contact: attributes_for(:contact, phones_attributes: @phones)}.to change(Contact, :count).by(1)
	      end
	      it "redirects to contact#show" do
	      	post :create, contact: attributes_for(:contact, phones_attributes: @phones)
	      	expect{response}.to redirect_to contact_path(assigns[:contact])
	      end
	    end       
	    context "with invalid attributes" do
	      it "does not save the new contact in database" do
	      	expect{post :create, contact: attributes_for(:invalid_contact, phones_attributes: @phones)}.to_not change(Contact, :count)
	      end
	      it "redirects to contact#new" do
	       	post :create, contact: attributes_for(:invalid_contact, phones_attributes: @phones)
	       	expect{response}.to render_template :new
	      end
	    end
	  end

	  describe "PUT #update" do
	  	before :each do 
	      @contact = create(:contact, firstname: "du", lastname: "xiaolong")
	  	end
	  	context "with valid attributes" do
	  	  it "updates the contact in the database" do
	        patch :update, id: @contact, contact: attributes_for(:contact, firstname: "he", lastname:"xuan")
	        @contact.reload
	        expect(assigns(:contact).firstname).to eq "he" 
	        expect(assigns(:contact).lastname).to eq "xuan"
	  	  end
	  	  it "redirects to contact#show" do
	        patch :update, id: @contact, contact: attributes_for(:contact, firstname: "he", lastname:"xuan")
	  	  	expect(response).to redirect_to @contact
	  	  end
	  	end
	  	context "with invalid attributes" do
	  	  it "does not updates the contact int the database" do
	  	  	patch :update, id: @contact, contact: attributes_for(:contact, firstname: "nil", lastname: "xuan")
	  	  	@contact.reload
	  	  end
	  	  it "redirects to contact#edit" do
	        patch :update, id: @contact, contact: attributes_for(:contact, firstname: nil, lastname:"xuan")
	  	    expect(response).to render_template :edit
	  	  end
	  	end
	  end

	  describe "DELETE #delete" do
	  	it "deletes the contact in the database" do
	  	  contact = create(:contact)
	  	  expect{delete :destroy, id: contact}.to change(Contact, :count).by(-1)
	  	end
	  	it "redirects to contact#index" do
	  	  contact = create(:contact)
	  	  delete :destroy, id: contact
	  	  expect{response}.to redirect_to contacts_url
	  	end
	  end
	end

	describe "guest access" do
	  describe "GET #new" do
	  	it "requires login" do
	  	  get :new
	  	  expect(response).to redirect_to login_url
	  	end
	  end
	end
end
