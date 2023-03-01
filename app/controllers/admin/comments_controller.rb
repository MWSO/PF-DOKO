class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.all.page(params[:page]).per(20)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_user_path(comment.user_id)
  end

end
