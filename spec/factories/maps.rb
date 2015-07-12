FactoryGirl.define do
  factory :map do
    name { Faker::Name.first_name }
  end
end
