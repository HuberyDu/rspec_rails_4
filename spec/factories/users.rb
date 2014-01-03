require "faker"

FactoryGirl.define do
  factory :user do
  	email {Faker::Internet.email}
  	password "11111111"
  	password_confirmation "11111111"

  	factory :admin do
  	  admin true
  	end
  end
end