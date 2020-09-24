class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @photo  = current_user.photos.build
      @feed_items = current_user.feed
    end
  end
end
