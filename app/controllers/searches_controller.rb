class SearchesController < ApplicationController
  def search
    @range = params[:range]
    if @range == "User"
      @users = User.where("name LIKE?", "%#{params[:word]}%")
    else
      @posts = Post.where("body LIKE?", "%#{params[:word]}%")
    end
  end
end
