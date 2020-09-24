require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @photo = @user.photos.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @photo.valid?
  end

  test "user id should be present" do
    @photo.user_id = nil
    assert_not @photo.valid?
  end
  
  test "content should be at most 140 characters" do
    @photo.content = "a" * 141
    assert_not @photo.valid?
  end
  
  test "order should be most recent first" do
    assert_equal photos(:most_recent), Photo.first
  end
end
