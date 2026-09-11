class Public::HomesController < ApplicationController
  def top
    @posts = Post.order(created_at: :desc)
    @categories = Category.all
  end

  # def about
  #   @post = Post.find(1)
  # end

  def test; end
  
end
