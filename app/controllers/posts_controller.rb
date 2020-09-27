class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def new
    @post = Post.new
    @post.photos.build
  end
  
  def create
    @post = Post.new(post_params)
    if @post.photos.present?
      @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to root_path
    else
      @feed_items = current_user.feed
      flash[:alert] = "投稿に失敗しました"
      render 'static_pages/home'
    end
  end

  def destroy
  end
  
  private
  
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
    end

end
