class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post
    if @comment.save
      @post = @comment.post
      @post.create_notification_comment!(current_user, @comment.id)
      respond_to :js
    else
      flash[:alert] = "コメントに失敗しました"
    end
  end
  
  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "コメントの削除に失敗しました"
    end
  end
  
  private
    def comment_params
      params.required(:comment).permit(:user_id, :post_id, :comment)
    end
end
