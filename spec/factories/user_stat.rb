FactoryGirl.define do
  factory :user_stat do
    user
    name    { Faker::Product.name.downcase.parameterize }
    value   { rand(100) }
  end
end
