FactoryBot.define do
  factory :chat do
    number { Faker::Number.digit }
    messages_count { Faker::Number.digit }
    application_id { nil }
  end
end
