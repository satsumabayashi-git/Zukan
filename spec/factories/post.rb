FactoryBot.define do
  factory :post do
    # id { 0 }
    # user_id { rand(100..105) }
    user_id { rand(1000..1005) }
    # user_id { 1 }
    category_id { rand(1000..1005) }
    body { Faker::Lorem.characters(number:20) }
    date { Faker::Date.backward(days: 365) }
    place { Faker::Travel::TrainStation.name(region: 'united_states') }
    memo { Faker::Lorem.characters(number:50) }

    after(:build) do |post|
      post.image.attach(
        io: File.open(Rails.root.join("spec/fixtures/sample_post1.jpg")),
        filename: "sample_post1.jpg",
        content_type: "image/jpeg"
      )
    end
  end
end