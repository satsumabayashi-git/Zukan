class Public::HomesController < ApplicationController
  def top
  end

  def about
    @post = Post.find(1)
  end

  def test
  end
  
end
