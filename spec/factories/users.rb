# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "u#{n}@#{Faker::Internet.domain_name}" }
    first_name { Faker::Name.name.split(' ').first }
    last_name { Faker::Name.name.split(' ').last }
    password 'password'
    position { ['DBA', 'Programmer', 'System Engineer'].sample }
    sequence(:employee_number) {|n| n }
    department 'Information Technology Service'
  end

  factory :user_admin, :parent => :user do
    email 'phatograph@gmail.com'
  end
end
