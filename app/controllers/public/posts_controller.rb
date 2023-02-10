class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to post_path(@post)
      else
        redirect_to my_page_path
      end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_comments = @post.comments.all.order(created_at: :desc).limit(5)

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.update(post_params)
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
