require 'rails_helper'

RSpec.describe PostComment, "モデルに関するテスト", type: :model do
  before do
    (1000..1005).each do |i|
      # FactoryBot.create(:user, id: i)
      # FactoryBot.create(:post, id: i)
    end
  end
  describe '実際に保存してみる' do
    it "有効なコメントの場合は保存されるか" do
      expect(FactoryBot.build(:post_comment)).to be_valid
    end
    context "空白のバリデーションチェック" do
      it "バリデーションチェックされ空白のエラーメッセージが返ってきているか", spec_category: "バリデーションとメッセージ表示" do
        post_comment = FactoryBot.build(:post_comment, comment: "")
        expect(post_comment).to be_invalid
        expect(post_comment.errors[:comment]).to include("を入力してください")
      end
    end
  end

  feature "コメントを空白で投稿した場合に画面にエラーメッセージが表示されているか" do
    before do
      user = User.find(1000)
      post = Post.find(1000)
      sign_in user
      visit post_path(1000)
    end
    scenario "エラーメッセージは正しく表示されるか", spec_category: "バリデーションとメッセージ表示" do
      # fill_in('post_comment[comment]', with: "コメントです")
      find_button("コメントする").click
      expect(page).to have_content "コメントを入力してください"
    end
  end
end