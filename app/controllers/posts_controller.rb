class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_post, only: [:show, :destroy]
  
  def new
    @post = current_user.posts.build
  end
  
  def show
  end
  
  def create
    @post = current_user.posts.build(post_params)
    @post.image.attach(params[:post][:image])
    if @post.save
      flash[:success] = "投稿に成功しました"
      redirect_to root_url
    else
      @feed_items = current_user.feed
      render 'static_pages/home'
    end
  end

  def destroy
    if @post.user == current_user
      flash[:success] = "投稿が削除されました" if @post.destroy
    else
      flash[:alert] = "投稿の削除に失敗しました"
    end
    redirect_to root_path
  end

  private

    def post_params
      params.require(:post).permit(:caption, :image)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
    
    def set_post
      @post = Post.find_by(id: params[:id])
    end
end
