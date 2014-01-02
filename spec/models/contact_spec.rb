require "spec_helper"

describe Contact do
  it "is valid with firstname, lastname, email" do
    expect(build(:contact)).to be_valid
  end

  it "is invalid without firstname" do
  	expect(build(:contact, firstname: nil)).to have(1).errors_on(:firstname)
  end

  it "is invalid without lastname" do
  	expect(build(:contact, lastname: nil)).to have(1).errors_on(:lastname)
  end

  it "is invalid without email" do
  	expect(build(:contact, email: nil)).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email address" do
  	create(:contact, email: "duxiaolong@gmail.com")
  	contact = build(:contact, email: "duxiaolong@gmail.com")
  	expect(contact).to have(1).errors_on(:email)
  end

  it "return a contact's full name as a string" do
  	contact = build(:contact, firstname: "joe", lastname: "green", email:"58009@gmail.com")
  	expect(contact.name).to eq "joe green"
  end

  describe "filter lastname by letter" do
  	before :each do
  		@xiaolong = create(:contact, firstname: "xiaolong", lastname: "du")
  		@xuan = create(:contact, firstname: "xuan", lastname: "du")
  		@hei = create(:contact, firstname: "hei", lastname: "hei")
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

  it "has a valid factory" do
    expect(FactoryGirl.build(:contact)).to be_valid
  end

  it "has three phone number" do
    expect(create(:contact).phones.count).to eq 3 
  end
 end