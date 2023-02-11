class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
      @post.user_id = current_user.id
      tag_list = params[:post][:name].split(nil)
      if @post.save
        @post.save_tag(tag_list)
        redirect_to post_path(@post)
      else
        redirect_to my_page_path
      end
  end

  def index
    @posts = Post.all
    @tag_list = Tag.all
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
      @post.update(post_params)
      input_tags = params[:post][:name].split(nil)
      @post.update_tags(input_tags)
      redirect_to post_path(@post)
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
