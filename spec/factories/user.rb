FactoryBot.define do
  factory :user do
    # id {}
    name { Faker::Lorem.characters(number:10) }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number:10) }
    favorite_animal { Faker::Lorem.characters(number:10) }
    introduction { Faker::Lorem.characters(number:50) }

    after(:build) do |user|
      user.profile_image.attach(
        io: File.open(Rails.root.join("spec/fixtures/sample_post1.jpg")),
        filename: "sample_post1.jpg",
        content_type: "image/jpeg"
      )
    end
  end
end