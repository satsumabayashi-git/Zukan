class Admin::DashboardsController < ApplicationController
  layout 'admin'
  # before_action :authenticate_admin!
  def index
    @users_count = User.all.count
    @posts_count = Post.all.count
  end
end
