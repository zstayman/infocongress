FactoryGirl.define do 
  factory :user do
    first_name {Faker::Name.first_name}
    last_name { Faker::Name.last_name }
    zip { 11226 }
    email { Faker::Internet.email }
    password "test"
    password_confirmation "test"
  end
end 