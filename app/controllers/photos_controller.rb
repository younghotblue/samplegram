class PhotosController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def new
    @photo = current_user.photos.build if logged_in?
  end
  
  def create
    @photo = current_user.photos.build(photo_params)
    @photo.image.attach(params[:photo][:image])
    if @photo.save
      flash[:success] = "投稿されました！"
      redirect_to root_url
    else
      render 'photos/new'
    end
  end

  def destroy
    @photo.destroy
    flash[:success] = "投稿が削除されました。"
    redirect_to request.referrer || root_url
  end
  
  private

    def photo_params
      params.require(:photo).permit(:content, :image)
    end
    
    def correct_user
      @photo = current_user.photos.find_by(id: params[:id])
      redirect_to root_url if @photo.nil?
    end
end
