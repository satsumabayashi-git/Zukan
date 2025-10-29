class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @categorys = Category.all
  end

  def index
    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    elsif params[:bookmark_count]
      posts = Post.all
      @posts = posts.sort_by { |post| post.bookmarks.count }.reverse!
    else
      @posts = Post.all.reverse
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to posts_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      @categorys = Category.all
      render :new
    end
  end

  def edit
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def bookmarked_index
    bookmarks = current_user.bookmarks
    bookmarked_posts = Post.where(id: [bookmarks.pluck(:post_id)])
    if params[:latest]
      @posts =  bookmarked_posts.latest
    elsif params[:old]
      @posts =  bookmarked_posts.old
    elsif params[:bookmarked_old]
      @posts =  bookmarked_posts.sort_by { |post| bookmarks.find_by(post_id: post.id).created_at }
    else
      @posts = bookmarked_posts.sort_by { |post| bookmarks.find_by(post_id: post.id).created_at }.reverse
    end
  end

private

def post_params
  params.require(:post).permit(:body, :image, :date, :place, :category_id)
end

end
