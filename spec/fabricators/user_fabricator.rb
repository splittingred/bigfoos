Fabricator(:user) do
  name  { Faker::Name.name }
  email { Faker::Internet.email }
  uid   { Faker::Identification.ssn }
  password { Faker::Product.name }
  wl_ratio 0.00
  score 0
end
