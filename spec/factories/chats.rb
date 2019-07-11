FactoryBot.define do
  factory :chat do
    chat_number { Faker::Number.number(6) }
    messages_count { Faker::Number.digit }
    application_id { nil }
  end
end
