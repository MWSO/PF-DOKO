class Admin::CommentsController < ApplicationController

  def index
    @comments = Comment.all.page(params[:page]).per(15)
  end

end
