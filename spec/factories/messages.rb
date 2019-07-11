FactoryBot.define do
  factory :message do
    message_number { Faker::Number.number(6) }
    body { Faker::Lorem.sentence }
    chat_id { nil }
  end
end
