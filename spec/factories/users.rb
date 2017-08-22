FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    phone_number Faker::PhoneNumber.phone_number
    password 'password'
  end

  factory :fake_user, class: User do
    email 'fake@examplec.com'
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    phone_number Faker::PhoneNumber.phone_number
    password 'pwd'
  end
end
