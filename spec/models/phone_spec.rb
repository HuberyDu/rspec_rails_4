require 'spec_helper'

describe Phone do
  it "doesn't allow duplicate phone numbers per contact" do
  	contact = create(:contact)
  	home_phone = create(:home_phone, contact: contact, phone: "11111111")
  	mobile_phone = build(:mobile_phone, contact: contact, phone: "11111111")
  	# expect(:mobile_phone).to have(1).errors_on(:phone)
  end

end