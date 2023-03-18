class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
      @post.user_id = current_user.id
      tag_list = params[:post][:name].split(nil)
      if @post.save
        #手動タグ付け
        @post.save_tag(tag_list)
        #AIによるタグ付け
        if tag_list.count == 0
          tags = Vision.get_image_data(@post.post_image)
          #AIタグの日本語化
          project_id = ENV["CLOUD_PROJECT_ID"]
          translate   = Google::Cloud::Translate.new version: :v2, project_id: project_id
          target = "ja"
          ja_tags = []
          tags.each do |tag|
            @translation = translate.translate tag, to: target
            ja_tags.push(@translation.text)
          end
          @post.save_tag(ja_tags)
        end
        redirect_to post_path(@post)
      else
        render :new
      end
  end

  def index
    @posts = Post.all.page(params[:page]).per(18)
    @tag_list = Tag.all
    @search_posts = Post.ransack(params[:q])
    @search_result = @search_posts.result.page(params[:page]).per(18)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_comments = @post.comments.all.order(created_at: :desc).limit(5)
    @post_tags = @post.tags

  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(" ")
  end

  def update
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      if @post.update(post_params)
        #手動タグ付け
        input_tags = params[:post][:name].split(nil)
        #AIによるタグ付け
        @post.update_tags(input_tags)
        if input_tags.count == 0
          tags = Vision.get_image_data(@post.post_image)
          #AIタグの日本語化
          project_id = ENV["CLOUD_PROJECT_ID"]
          translate   = Google::Cloud::Translate.new version: :v2, project_id: project_id
          target = "ja"
          ja_tags = []
          tags.each do |tag|
            @translation = translate.translate tag, to: target
            ja_tags.push(@translation.text)
          end
          @post.update_tags(ja_tags)
        end
        redirect_to post_path(@post)
      else
        render :edit
      end
    else
      redirect_to my_page_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.destroy
      redirect_to posts_path
    else
      redirect_to my_page_path
    end
  end

private

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :location, :user_id)
  end

end
