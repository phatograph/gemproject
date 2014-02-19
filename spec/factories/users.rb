# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "u#{n}@#{Faker::Internet.domain_name}" }
    first_name { Faker::Name.name.split(' ').first }
    last_name { Faker::Name.name.split(' ').last }
    password 'password'
  end
end
