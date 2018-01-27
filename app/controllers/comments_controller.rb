class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.blog_id = params[:blog_id]
    # @comment.blog_id
    if @comment.save
      # blog = Blog.find(params.require(:comment).permit(:blog_id)[:blog_id])
      redirect_to blog_path(params[:blog_id])
    end
  end

private
  def comment_params
  params.require(:comment).permit(:comment, :blog_id, :user_id)
  end

end
