FactoryBot.define do
  factory :room_rent do
    started_at { 3.days.from_now }
    finish_at { 1.year.from_now }
    description { Faker::Lorem.paragraph(sentence_count: 25) }
    user 
    room 
    price { Faker::Commerce.price(range: 800.0..10000.0) }
  end
end
