FactoryGirl.define do 
  factory :elected do
    first_name {Faker::Name.first_name}
    last_name { Faker::Name.last_name }
    house "house"
    party "D"
    state "CT"
    biography "Q11011"
    bio_text "Filler"
  end
end 