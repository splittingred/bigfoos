FactoryGirl.define do
  factory :user_stat do
    user
    name    { FFaker::Product.name.downcase.parameterize }
    value   { rand(100) }
  end
end
