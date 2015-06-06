FactoryGirl.define do
  factory :user do
    name     { Faker::Name.name }
    email    { Faker::Internet.email }
    uid      { Faker::Identification.ssn }
    password { Faker::Product.name }
    score    { 0 }
  end
end
