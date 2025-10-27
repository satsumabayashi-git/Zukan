# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Kabutomaru = User.find_or_create_by!(email: "kabutomaru@example.com") do |user|
  user.name = "かぶと丸"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
  user.introduction = "昆虫をたくさん飼ってます！"
  user.favorite_animal = "エレファスゾウカブト"
end

Aruma = User.find_or_create_by!(email: "Aruma@example.com") do |user|
  user.name = "アルマ"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
  user.introduction = "バードウォッチングが趣味です。"
  user.favorite_animal = "ペリカン"
end

Nyaan = User.find_or_create_by!(email: "nyaan@example.com") do |user|
  user.name = "ニャーン"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
  user.introduction = "かわいい動物が大好きです！"
  user.favorite_animal = "サーバル"
end