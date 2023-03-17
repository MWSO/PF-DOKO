class Public::TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    project_id = ENV["CLOUD_PROJECT_ID"]
    translate   = Google::Cloud::Translate.new version: :v2, project_id: project_id
    target = "ja"
    tags = Tag.all.page(params[:page]).per(50)
    @tags = translate.translate tags, to: target

  end

end
