require 'test_helper'

class PhotosInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "photo interface" do
    log_in_as(@user)
    get new_photo_path
    # 有効な送信
    content = "This photo really ties the room together"
    assert_difference 'Photo.count', 1 do
      post photos_path, params: { photo: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: '削除'
    first_photo = @user.photos.first
    assert_difference 'Photo.count', -1 do
      delete photo_path(first_photo)
    end
    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    get user_path(users(:archer))
    assert_select 'a', text: '削除', count: 0
  end
end
