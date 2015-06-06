FactoryGirl.define do
  factory :player do
    user
    team
    points  { 0 }
  end
end
