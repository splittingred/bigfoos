Fabricator(:user) do
  name  Faker::Name.name
  email Faker::Internet.email
  uid   Faker::Identification.ssn
  password Faker::Product.name
end
