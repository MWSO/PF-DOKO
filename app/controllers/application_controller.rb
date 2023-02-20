class ApplicationController < ActionController::Base
  before_action :set_search
  before_action :rank

  def rank
    @post_favo_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    @tag_ranks = Tag.find(TagRelation.group(:tag_id).order('count(post_id) desc').limit(5).pluck(:tag_id))
  end

  def set_search
    @search_posts = Post.ransack(params[:q])
    @search_result = @search_posts.result.page(params[:page]).per(18)
  end

  private
    #サインイン後の遷移先
    def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(User)
        my_page_path
      else
        root_path
      end
    end
    #サインアウト後の遷移先
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
