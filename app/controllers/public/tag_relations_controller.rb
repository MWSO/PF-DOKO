class Public::TagRelationsController < ApplicationController

  def index
    @tag_lists = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all.page(params[:page]).per(18)
  end
end
