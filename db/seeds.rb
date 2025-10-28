# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.find_or_create_by!(name: "不明") do |post|
  
end

Category.find_or_create_by!(name: "昆虫・その他の虫") do |post|
  
end

Category.find_or_create_by!(name: "鳥類") do |post|
  
end

Category.find_or_create_by!(name: "魚類・水中の生物") do |post|
  
end

Category.find_or_create_by!(name: "爬虫類・両生類") do |post|
  
end

Category.find_or_create_by!(name: "哺乳類") do |post|
  
end

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

Post.find_or_create_by!(body: "何の幼虫でしょうか？お尻に角？が生えてました。") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.date = "２０２５年９月"
  post.place = "東京都大田区、倉庫街"
  post.user_id = 1
  post.category_id = 2
end

Post.find_or_create_by!(body: "白いハトがいました！皆さんは見かけたことありますか？") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.date = "２０２３年（たぶん）"
  post.place = "神奈川県川崎市、駅前"
  post.user_id = 2
  post.category_id = 3
end

Post.find_or_create_by!(body: "路地裏でタヌキ？を見かけました！アライグマかもしれません…") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.date = "２０２４年１０月"
  post.place = "神奈川県、住宅街"
  post.user_id = 2
  post.category_id = 6
end

bookmarks = Bookmark.create!(
  [
    {user_id: 2, post_id: 1},
    {user_id: 2, post_id: 3},
    {user_id: 3, post_id: 1},
  ]
)