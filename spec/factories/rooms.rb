FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "Room #{n}" }
    description { Faker::Lorem.paragraph(sentence_count: 35) }
    price { Faker::Commerce.price(range: 20.0..1000.0) }
    avaliable { true }
  end
end
