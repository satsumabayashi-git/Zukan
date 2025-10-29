class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    word = params[:word]
    if @range == "User"
      my_array_object = User.where("name LIKE? OR introduction LIKE? OR favorite_animal LIKE?", "%#{word}%", "%#{word}%", "%#{word}%")
      @users = Kaminari.paginate_array(my_array_object).page(params[:page])
    else
      my_array_object = Post.where("body LIKE? OR place LIKE? OR date LIKE?", "%#{word}%", "%#{word}%", "%#{word}%")
      @posts = Kaminari.paginate_array(my_array_object).page(params[:page])
    end
  end
  
end
