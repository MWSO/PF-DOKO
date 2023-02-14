class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @search_posts = Post.ransack(params[:q])
    @search_result = @search_posts.result
  end

  private

    def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(User)
        my_page_path
      else
        root_path
      end
    end

    def after_sign_out_path_for(resource_or_scope)
      if resource_or_scope == :user
        root_path
      elsif resource_or_scope == :admin
        new_admin_session_path
      else
        root_path
      end
    end

end
