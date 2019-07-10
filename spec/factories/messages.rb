FactoryBot.define do
  factory :message do
    number { Faker::Number.digit }
    body { Faker::Lorem.sentence }
    chat_id { nil }
  end
end
