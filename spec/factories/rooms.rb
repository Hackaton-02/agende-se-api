FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "Room #{n}" }
    description { Faker::Lorem.paragraphs }
    price { Faker::Commerce.price(range: 20.0..1000.0) }
  end
end
