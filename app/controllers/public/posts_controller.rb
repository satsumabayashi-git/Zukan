class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @categories = Category.all
  end

  def index
    @categories = Category.all
    case params[:order]
    when "old" then
      ordered_object = Post.old
    when "bookmark" then
      ordered_object = Post.all.sort_by { |post| post.bookmarks.count }.reverse!
    else
      ordered_object = Post.latest
    end
    @posts = Kaminari.paginate_array(ordered_object).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "送信に成功しました"
      redirect_to posts_path
    else
      flash.now[:danger] = "送信に失敗しました"
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "編集に成功しました"
      redirect_to posts_path(@post.id)
    else
      flash.now[:danger] = "編集に失敗しました"
      @categories = Category.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def bookmarked_index
    bookmarks = current_user.bookmarks
    bookmarked_posts = Post.where(id: [bookmarks.pluck(:post_id)])
    my_array_object =  bookmarked_posts
    @posts = Kaminari.paginate_array(my_array_object).page(params[:page])
  end

  def categorized
    @categories = Category.all
    bookmarks = current_user.bookmarks
    @category_id = params[:category_id]
    categorized_posts =  Post.where(category_id: @category_id)
    case params[:order]
    when "old" then
      ordered_object = categorized_posts.old
    when "bookmark" then
      ordered_object = categorized_posts.all.sort_by { |post| post.bookmarks.count }.reverse!
    else
      ordered_object = categorized_posts.latest
    end
    @posts = Kaminari.paginate_array(ordered_object).page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:body, :image, :date, :place, :memo, :category_id)
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    user = post.user
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end

end
