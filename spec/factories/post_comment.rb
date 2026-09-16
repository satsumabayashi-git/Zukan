FactoryBot.define do
  factory :post_comment do
    # id {}
    user_id { rand(1000..1005) }
    post_id { rand(1000..1005) }
    comment { Faker::Lorem.characters(number:20) }
  end
end