module ApplicationHelper
  
  def full_title(page_title = '')
    base_title = "Samplegram from Ruby on Rails"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def avatar_url(user)
    return user.profile_photo unless user.profile_photo.nil?
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
  end
end

