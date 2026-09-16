# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, "モデルに関するテスト", type: :model do
  before do
    (1000..1005).each do |i|
      # FactoryBot.create(:user, id: i)
      Category.create(id: i, name: "category#{i}")
    end
    user = User.find(1000)
    sign_in user
  end
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか", spec_category: "シンプルな投稿と保存の理解" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "body:バリデーションチェックされ空白のエラーメッセージが返ってきているか", spec_category: "バリデーションとメッセージ表示" do
      post = FactoryBot.build(:post, body: "")
      expect(post).to be_invalid
      expect(post.errors[:body]).to include("を入力してください")
    end
    it "image:バリデーションチェックされ空白のエラーメッセージが返ってきているか", spec_category: "バリデーションとメッセージ表示" do
      post = Post.new(body: 'hoge', user_id: rand(0..5), category_id: rand(0..5))
      expect(post).to be_invalid
      expect(post.errors[:image]).to include("を選択してください")
    end
    it "category:バリデーションチェックされ空白のエラーメッセージが返ってきているか", spec_category: "バリデーションとメッセージ表示" do
      post = FactoryBot.build(:post, category: nil)
      expect(post).to be_invalid
      expect(post.errors[:category]).to include("を選択してください")
    end
  end

  feature "要素を空白で投稿した場合に画面にエラーメッセージが表示されているか" do
    before do
      visit new_post_path
    end
    scenario "エラーメッセージ(body)は正しく表示されるか", spec_category: "バリデーションとメッセージ表示" do
      attach_file("画像をアップロード", "spec/fixtures/sample_post1.jpg", visible: false)
      choose("category1000")
      find_all("button[type='submit']")[1].click
      expect(page).to have_content "タイトルを入力してください"
      expect(page).not_to have_content "画像を選択してください"
      expect(page).not_to have_content "カテゴリを選択してください"
    end
    scenario "エラーメッセージ(image)は正しく表示されるか", spec_category: "バリデーションとメッセージ表示" do
      fill_in('post[body]', with: "タイトルです")
      choose("category1000")
      find_all("button[type='submit']")[1].click
      expect(page).not_to have_content "タイトルを入力してください"
      expect(page).to have_content "画像を選択してください"
      expect(page).not_to have_content "カテゴリを選択してください"
    end
    scenario "エラーメッセージ(categoy)は正しく表示されるか", spec_category: "バリデーションとメッセージ表示" do
      fill_in('post[body]', with: "body")
      attach_file("画像をアップロード", "spec/fixtures/sample_post1.jpg", visible: false)
      find_all("button[type='submit']")[1].click
      expect(page).not_to have_content "タイトルを入力してください"
      expect(page).not_to have_content "画像を選択してください"
      expect(page).to have_content "カテゴリを選択してください"
    end
  end
end
