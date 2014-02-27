# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timelog do
    started_at "2014-02-27 23:40:45"
    ended_at "2014-02-27 23:40:45"
    assignment nil
  end
end
