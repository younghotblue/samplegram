class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    @like.save
    post = Post.find(params[:post_id])
    post.create_notification_like!(current_user)
    respond_to :js
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private
    def like_params
      params.permit(:post_id)
    end
end
