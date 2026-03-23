FactoryBot.define do
  factory :employee do
    full_name { Faker::Name.name }
    job_title { Faker::Job.title }
    country { ['India', 'United States', 'Canada', 'United Kingdom', 'Germany'].sample }
    salary { Faker::Number.between(from: 30000, to: 200000) }
  end
end
