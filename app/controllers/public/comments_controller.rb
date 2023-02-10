class Public::CommentsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.all.page(params[:page]).per(15)
    @comment_new = Comment.new

  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    redirect_to post_path(@post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@comment.post_id)
  end

 private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :post_id)
  end

end
