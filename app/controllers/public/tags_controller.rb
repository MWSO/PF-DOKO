class Public::TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tags = Tag.all.page(params[:page]).per(50)
  end
end
