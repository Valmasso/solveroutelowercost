FactoryGirl.define do
  factory :map do
    name { Faker::Name.first_name }

    # map_with_paths will create path data after the map has been created
    factory :map_with_paths do
      # paths_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        paths_count 5
      end

      # the after(:create) yields two values; the map instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the map is associated properly to the path
      after(:create) do |map, evaluator|
        create_list(:path, evaluator.paths_count, map: map)
      end
    end

    factory :map_with_paths_defined do
      after(:create) do |map|
        create(:path, from: "D", to: "E", distance: 30, map: map)
        create(:path, from: "A", to: "C", distance: 20, map: map)
        create(:path, from: "C", to: "D", distance: 30, map: map)
        create(:path, from: "A", to: "B", distance: 10, map: map)
        create(:path, from: "B", to: "E", distance: 50, map: map)
        create(:path, from: "B", to: "D", distance: 15, map: map)
      end
    end
  end
end
