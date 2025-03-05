FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 100) }
    association :user
  end
end
