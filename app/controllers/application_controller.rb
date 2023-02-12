class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @search_posts = Post.ransack(params[:q])
    @search_result = @search_posts.result
  end


end
