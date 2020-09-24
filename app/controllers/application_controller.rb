class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_search

  def set_search
    @search = User.ransack(params[:q])
    @users = @search.result
  end
  
  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
end
