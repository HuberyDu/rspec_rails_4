require 'spec_helper'

describe Phone do
  it "doesn't allow duplicate phone numbers per contact" do
  	contact = create(:contact)
  	home_phone = create(:home_phone, contact: contact, phone: "11111111")
  	mobile_phone = build(:mobile_phone, contact: contact, phone: "11111111")
  end

end