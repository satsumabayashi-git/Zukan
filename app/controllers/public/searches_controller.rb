class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    word = params[:word]
    if @range == "User"
      @users = User.where("name LIKE? OR introduction LIKE? OR favorite_animal LIKE?", "%#{word}%", "%#{word}%", "%#{word}%")
    else
      @posts = Post.where("body LIKE? OR place LIKE? OR date LIKE?", "%#{word}%", "%#{word}%", "%#{word}%")
    end
  end
  
end
