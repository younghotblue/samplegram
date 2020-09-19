class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_search

  def set_search
    @search = User.ransack(params[:q])
    @users = @search.result
  end
end
