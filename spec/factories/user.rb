FactoryBot.define do
  factory :user do
    email { "#{Faker::Number.number(digits: 3)}-#{Faker::Internet.email}" }
    password  { "password" }
  end
end