FactoryGirl.define do
  factory :path do
    from     { Faker::Lorem.character }
    to       { Faker::Lorem.character }
    distance { Faker::Number.decimal(2) }
    map
  end
end
