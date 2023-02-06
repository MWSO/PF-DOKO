class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user)
  end

  def my_page
    @user = current_user
  end

  def withdrawal
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :like, :profile_image)
  end

end
