FactoryBot.define do
  factory :provider do
    name { Faker::Name.name }
    nit { "#{Faker::Number.number(digits: 9)}-#{Faker::Number.number(digits: 1)}" }
    contact_name { Faker::Name.name }
    contact_cellphone { "#{Faker::Number.number(digits: 10)}" }
    account_number { "#{Faker::Number.number(digits: 15)}" }
    bank { FactoryBot.create(:bank) }
  end
end