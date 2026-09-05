# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"

User.where("email LIKE?", "%@example.seed.com").destroy_all
# Category.all.destroy_all

# # カテゴリ作成
# categories = ["鳥類", "哺乳類", "爬虫類・両生類", "魚類・水中の生物", "昆虫・その他の虫", "不明"]

# categories.each_with_index do |name|
#   Category.find_or_create_by!(name: name)
# end

# ユーザー作成
names = ["かぶと丸", "はむたろう", "白狼", "ベッカム", "ワニくん"]
animals = ["エレファスゾウカブト", "チンチラ", "豆柴", "ペリカン", ""]

def find_or_create_user(name, animal, index)
  introduction = "よろしくお願いします、#{name}です。"
  password = "123456"
  email = "seed#{index + 1}@example.seed.com"

  # ランダムな日付を生成
  min_days_ago = 1
  max_days_ago = 365
  random_days_ago = rand(min_days_ago..max_days_ago)
  random_date = Time.now - random_days_ago.days

  user = User.find_or_create_by!(email: email) do |u|
    u.name = name
    u.password = password
    u.introduction = introduction
    u.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user#{index + 1}.jpg"), filename:"sample-user#{index}.jpg")
    u.favorite_animal = animal
    u.created_at = random_date
    u.updated_at = random_date
  end

  if user.persisted?
    puts "ユーザーが作成されました: #{user.name}"
  else
    puts "ユーザー作成中にエラーが発生しました:"
    puts user.errors.full_messages
  end
end

names.each_with_index do |name, index|
  animal = animals[index]
  find_or_create_user(name, animal, index)
end

# 投稿作成
def create_posts_for_user_with_ordered_dates(user, count, index)
  initial_date = Time.now - (count - 1).days
  sample_image_category = [4, 4, 3, 0, 0, 1, 4, 2, 4, 2]

  count.times do |i|
    body = "投稿#{i + 1}by#{user.name}"
    date = "#{rand(1..12)}月#{rand(1..31)}日"
    place = "場所#{i + 1}"
    memo = "サンプルの投稿#{i + 1}です。by#{user.name}"

    # 日付を順番に遅らせる
    post_date = initial_date + i.days

    post_params = {
      body: body,
      user_id: user.id
    }

    post = Post.find_or_create_by!(post_params) do |p|
      p.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post#{index*2 + i + 1}.jpg"), filename:"sample-post#{index*2 + i + 1}.jpg")
      p.category_id = sample_image_category[index*2 + i]
      p.date = date
      p.place = place
      p.memo = memo
      p.created_at = post_date
      p.updated_at = post_date
    end

    puts "作成された投稿: #{body}, user: #{user.name}"
  end
end

User.where("email LIKE?", "%@example.seed.com").each_with_index do |user, index|
  count = 2
  create_posts_for_user_with_ordered_dates(user, count, index)
end


# bookmarks = Bookmark.create!(
#   [
#     {user_id: 2, post_id: 1},
#     {user_id: 2, post_id: 3},
#     {user_id: 3, post_id: 1},
#   ]
# )

puts "seedの実行が完了しました"