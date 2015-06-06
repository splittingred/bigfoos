FactoryGirl.define do
  factory :user do
    name     { FFaker::Name.name }
    email    { FFaker::Internet.email }
    uid      { FFaker::Identification.ssn }
    password { FFaker::Product.name }
    score    { 0 }
  end
end
