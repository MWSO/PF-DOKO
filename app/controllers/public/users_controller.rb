class Public::UsersController < ApplicationController
  before_action :check_user, only: [:my_list]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user == current_user
      user.update(user_params)
      redirect_to user_path(user)
    else
      redirect_to my_page_path
    end
  end

  def my_page
    @user = current_user
    @post = @user.posts.all
  end

  def withdrawal
    @user = current_user
  end

  def status
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def my_list
   favorite = Favorite.where(user_id: @user.id).pluck(:post_id)
   @favo_posts = Post.find(favorite)
  end


private

  def user_params
    params.require(:user).permit(:name, :introduction, :like, :profile_image)
  end

  def check_user
    @user = User.find(params[:id])
  end

end
