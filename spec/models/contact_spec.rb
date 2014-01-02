require "spec_helper"

describe Contact do
  it "is valid with firstname, lastname, email" do
    contact = Contact.new(firstname: "joe", lastname: "green", email:"58009@gmail.com")
    expect(contact).to be_valid
  end

  it "is invalid without firstname" do
  	expect(Contact.new(firstname: nil)).to have(1).errors_on(:firstname)
  end

  it "is invalid without lastname" do
  	expect(Contact.new(lastname: nil)).to have(1).errors_on(:lastname)
  end

  it "is invalid without email" do
  	expect(Contact.new(email: nil)).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email address" do
  	contact01 = Contact.create(firstname: "joe", lastname: "green", email:"58009@gmail.com")
  	contact02 = Contact.new(firstname: "joe", lastname: "green", email:"58009@gmail.com")
  	expect(contact02).to have(1).errors_on(:email)
  end

  it "return a contact's full name as a string" do
  	contact = Contact.new(firstname: "joe", lastname: "green", email:"58009@gmail.com")
  	expect(contact.name).to eq "joe green"
  end

  describe "filter lastname by letter" do
  	before :each do
  		@xiaolong = Contact.create(firstname: "xiaolong", lastname: "du", email:"duxiaolong@gmail.com")
  		@xuan = Contact.create(firstname: "xuan", lastname: "du", email:"xuan@gmail.com")
  		@hei = Contact.create(firstname: "hei", lastname: "hei", email: "hei@gmail.com")
  	end

  	context "matching by letter" do
      it "returns a sorted array of result that match" do
	  	expect(Contact.by_letter("du")).to eq [@xiaolong, @xuan]
	  end
  	end

  	context "non-matching by letter " do
  	  it "only returns contacts with the provided starting letter" do
  	    expect(Contact.by_letter("du")).to_not include @hei 
  	  end
  	end
  end
end