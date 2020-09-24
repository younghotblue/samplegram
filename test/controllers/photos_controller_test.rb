require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @photo = photos(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Photo.count' do
      post photos_path, params: { photo: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Photo.count' do
      delete photo_path(@photo)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong photo" do
    log_in_as(users(:michael))
    photo = photos(:ants)
    assert_no_difference 'Photo.count' do
      delete photo_path(photo)
    end
    assert_redirected_to root_url
  end
end
