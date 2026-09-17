require 'rails_helper'

describe '投稿のテスト' , type: :system do
  let!(:post) { FactoryBot.create(:post) }
  let!(:user) { FactoryBot.create(:user) }
  let(:main) { page.find('main') }
  let(:list) {page.find('#post-list')}
  let(:detail) { page.find('#post-detail') }
  let(:comments) { page.find('#comments') }
  before do 
    sign_in user
  end
  # describe 'トップ画面(root_path)のテスト' do
  #     6.times {FactoryBot.create(:post)}
  #   before do 
  #     visit root_path
  #   end
  #   context '表示の確認' do
  #     it 'ページの見出しが表示されるか', spec_category: "ビューページでの適切な遷移先設定" do
  #       expect(main).to have_content 'TOPページ'
  #     end
  #     it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか', spec_category: "ルーティング・URL設定の理解" do
  #       expect(main).to have_link "", href: posts_path
  #     end
  #     it 'root_pathが"/"であるか', spec_category: "ルーティング・URL設定の理解" do
  #       expect(current_path).to eq('/')
  #     end
  #   end
  # end

  # describe "一覧画面のテスト" do
  #   6.times { |i| FactoryBot.create(:post, body: "タイトル#{i}")}
  #   before do
  #     visit posts_path
  #   end
  #   context '表示とリンクの確認' do
  #     it 'ページの見出しが表示されるか', spec_category: "ビューページでの適切な遷移先設定" do
  #       expect(main).to have_content '投稿一覧'
  #     end
  #     it "postの一覧表示、カテゴリ検索ボタン、並び替えリンクが同一画面に表示されているか", spec_category: "ビューページでの適切な遷移先設定" do
  #       expect(main).to have_button 'カテゴリ検索'
  #       expect(main).to have_link "新着順", href: posts_path
  #       expect(main).to have_link "古い順", href: posts_path(order: "old")
  #       expect(main).to have_link "ブックマーク順", href: posts_path(order: "bookmark")
  #     end
  #     it "postのカテゴリ、タイトル、写真を表示し、カテゴリ検索リンク、詳細リンク、ユーザーリンク、ブックマークボタンが表示されているか", spec_category: "ビューページでの適切な遷移先設定" do
  #       Post.last(6).reverse.each_with_index do |post,i|
  #         filename = post.image.filename.to_s
  #         j = i * 4
  #         expect(list).to have_content post.body
  #         expect(list).to have_content post.category.name
  #         expect(list).to  have_selector("img[src$='#{filename}']")
  #         # カテゴリ検索リンク
  #         category_link = list.find_all('a')[j]
  #         expect(category_link.native.inner_text).to match(/#{post.category.name}/i)
  #         expect(category_link[:href]).to eq categorized_path(post.category.id)
  #         # 詳細リンク
  #         show_link = list.find_all('a')[j+1]
  #         expect(show_link.native.inner_text).to match(//)
  #         expect(show_link[:href]).to eq post_path(post)
  #         # ユーザーリンク
  #         show_link = list.find_all('a')[j+2]
  #         expect(show_link.native.inner_text).to match(//)
  #         expect(show_link[:href]).to eq user_path(post.user)
  #         # ブックマークボタン
  #         show_link = list.find_all('form')[i]
  #         expect(show_link.native.inner_text).to match(//)
  #         expect(show_link[:action]).to eq post_bookmark_path(post)
  #       end
  #     end
  #   end
  # end

  describe '詳細画面のテスト' do
    context '投稿詳細の表示の確認' do
      
      before do
        visit post_path(post)
      end
      it 'ページの見出しが表示される', spec_category: "ビューページでの適切な遷移先設定" do
        expect(main).to have_content '投稿詳細'
      end
      it 'カテゴリ名、投稿日、タイトル、写真、コメント数、ブックマーク数が表示される', spec_category: "ビューページでの適切な遷移先設定" do
        (1..5).each do |i|
          Bookmark.create(user_id: i, post_id: post.id)
          FactoryBot.create(:post_comment, user_id: i, post_id: post.id)
        end
        visit post_path(post)
        filename = post.image.filename.to_s
        expect(detail).to have_content post.category.name
        expect(detail).to have_content post.created_at.strftime('%Y/%m/%d')
        expect(detail).to have_content post.body
        expect(detail).to  have_selector("img[src$='#{filename}']")
        expect(detail).to have_content post.post_comments.count
        expect(detail).to have_content post.bookmarks.count
      end
      it '編集ボタンと削除ボタンが表示されない', spec_category: "ビューページでの適切な遷移先設定" do
        expect(detail).not_to have_selector 'a', text: '編集'
        expect(detail).not_to have_button "削除"
      end
      it '編集ボタンと削除ボタンが表示される', spec_category: "ビューページでの適切な遷移先設定" do
        post2 = FactoryBot.create(:post, user_id: user.id)
        visit post_path(post2)
        expect(detail).to have_selector 'a', text: '編集'
        expect(detail).to have_button "削除"
      end
    end
    context 'リンクの遷移先の確認' do
      it 'Editの遷移先は編集画面か', spec_category: "ルーティング・URL設定の理解" do
        post2 = FactoryBot.create(:post, user_id: user.id)
        visit post_path(post2)
        click_link '編集', match: :first
        expect(current_path).to eq('/posts/' + post2.id.to_s + '/edit')
      end
    end
    context 'post削除のテストと遷移先の確認' do
      it 'postの削除', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
        post2 = FactoryBot.create(:post, user_id: user.id)
        visit post_path(post2)
        before_delete_post = Post.count
        click_button '削除', match: :first
        after_delete_post = Post.count
        expect(before_delete_post - after_delete_post).to eq(1)
        expect(current_path).to eq('/posts')
      end
    end
  end

  # describe "新規作成画面のテスト" do
  #   before do
  #     visit new_post_path
  #   end
  #   # context '一覧の表示とリンクの確認' do
  #   #   it "postの一覧表示(tableタグ)と投稿フォームが同一画面に表示されているか", spec_category: "ビューページでの適切な遷移先設定" do
  #   #     expect(page).to have_selector 'table'
  #   #     expect(page).to have_field 'post[title]'
  #   #     expect(page).to have_field 'post[body]'
  #   #   end
  #   #   it "postのタイトルと感想を表示し、詳細・編集・削除のリンクが表示されているか", spec_category: "ビューページでの適切な遷移先設定" do
  #   #       (1..5).each do |i|
  #   #         Post.create(title:'hoge'+i.to_s,body:'body'+i.to_s)
  #   #       end
  #   #       visit posts_path
  #   #       Post.all.each_with_index do |post,i|
  #   #         j = i * 3
  #   #         expect(page).to have_content post.title
  #   #         expect(page).to have_content post.body
  #   #         # Showリンク
  #   #         show_link = find_all('a')[j]
  #   #         expect(show_link.native.inner_text).to match(/show/i)
  #   #         expect(show_link[:href]).to eq post_path(post)
  #   #         # Editリンク
  #   #         show_link = find_all('a')[j+1]
  #   #         expect(show_link.native.inner_text).to match(/edit/i)
  #   #         expect(show_link[:href]).to eq edit_post_path(post)
  #   #         # Destroyリンク
  #   #         show_link = find_all('a')[j+2]
  #   #         expect(show_link.native.inner_text).to match(/destroy/i)
  #   #         expect(show_link[:href]).to eq post_path(post)
  #   #       end
  #   #   end
  #   #   it 'Create Postボタンが表示される', spec_category: "ビューページでの適切な遷移先設定" do
  #   #     expect(page).to have_button 'Create Post'
  #   #   end
  #   # end
  #   # context '投稿処理に関するテスト' do
  #   #   it '投稿に成功しサクセスメッセージが表示されるか', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
  #   #     fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
  #   #     fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
  #   #     click_button 'Create Post'
  #   #     expect(page).to have_content 'successfully'
  #   #   end
  #   #   it '投稿に失敗する', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
  #   #     click_button 'Create Post'
  #   #     expect(page).to have_content 'error'
  #   #     expect(current_path).to eq('/posts')
  #   #   end
  #   #   it '投稿後のリダイレクト先は正しいか', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
  #   #     fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
  #   #     fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
  #   #     click_button 'Create Post'
  #   #     expect(page).to have_current_path post_path(Post.last)
  #   #   end
  #   # end
  #   # context 'post削除のテスト' do
  #   #   it 'application.html.erbにjavascript_pack_tagを含んでいるか', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
  #   #     is_exist = 0
  #   #     open("app/views/layouts/application.html.erb").each do |line|
  #   #       strip_line = line.chomp.gsub(" ", "")
  #   #       if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
  #   #         is_exist = 1
  #   #         break
  #   #       end
  #   #     end
  #   #     expect(is_exist).to eq(1)
  #   #   end
  #   #   it 'postの削除', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
  #   #     before_delete_post = Post.count
  #   #     click_link 'Destroy', match: :first
  #   #     after_delete_post = Post.count
  #   #     expect(before_delete_post - after_delete_post).to eq(1)
  #   #     expect(current_path).to eq('/posts')
  #   #   end
  #   # end
  # end

  # describe '編集画面のテスト' do
  #   before do
  #     visit edit_post_path(post)
  #   end
  #   context '表示の確認' do
  #     it '編集前のタイトルと感想がフォームに表示(セット)されている', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
  #       expect(page).to have_field 'post[title]', with: post.title
  #       expect(page).to have_field 'post[body]', with: post.body
  #     end
  #     it 'Update Postボタンが表示される', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
  #       expect(page).to have_button 'Update Post'
  #     end
  #     it 'Showリンクが表示される', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
  #       show_link = find_all('a')[0]
  #       expect(show_link.native.inner_text).to match(/show/i)
	# 		end  
  #     it 'Backリンクが表示される', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
  #       back_link = find_all('a')[1]
  #       expect(back_link.native.inner_text).to match(/back/i)
	# 		end  
  #   end
  #   context 'リンクの遷移先の確認' do
  #     it 'Showの遷移先は詳細画面か', spec_category: "ルーティング・URL設定の理解" do
  #       show_link = find_all('a')[0]
  #       show_link.click
  #       expect(current_path).to eq('/posts/' + post.id.to_s)
  #     end
  #     it 'Backの遷移先は一覧画面か', spec_category: "ルーティング・URL設定の理解" do
  #       back_link = find_all('a')[1]
  #       back_link.click
  #       expect(page).to have_current_path posts_path
  #     end
  #   end
  #   context '更新処理に関するテスト' do
  #     it '更新に成功しサクセスメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
  #       fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
  #       fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
  #       click_button 'Update Post'
  #       expect(page).to have_content 'successfully'
  #     end
  #     it '更新に失敗しエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
  #       fill_in 'post[title]', with: ""
  #       fill_in 'post[body]', with: ""
  #       click_button 'Update Post'
  #       expect(page).to have_content 'error'
  #     end
  #     it '更新後のリダイレクト先は正しいか', spec_category: "バリデーションとメッセージ表示" do
  #       fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
  #       fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
  #       click_button 'Update Post'
  #       expect(page).to have_current_path post_path(post)
  #     end
  #   end
  # end
end