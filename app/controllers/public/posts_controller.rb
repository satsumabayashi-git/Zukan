class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @categorys = Category.all
  end

  def index
    @posts = Post.all
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

private

def post_params
  params.require(:post).permit(:body, :image, :date, :place)
end

end
