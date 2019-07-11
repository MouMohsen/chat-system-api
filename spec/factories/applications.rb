FactoryBot.define do
  factory :application do
    token { Faker::Lorem.characters }
    name { Faker::Lorem.word }
    chats_count { nil }
  end
end
