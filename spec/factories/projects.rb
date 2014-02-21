# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:name) {|n| "#{Faker::Company.name} #{n}".delete(%q[&"'><]) }

    factory :project_with_tasks do
      ignore do
        tasks_count 5
      end

      after(:create) do |project, evaluator|
        create_list(:task, evaluator.tasks_count, :project => project)
      end
    end
  end
end
