FactoryGirl.define do
  factory :task do
    name { Faker::Company.name }
    project
  end
end
