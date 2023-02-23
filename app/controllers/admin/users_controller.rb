class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page]).per(12)
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admin_users_path
  end

 private

  def user_params
    params.require(:user).permit(:is_deleted)
  end

end
