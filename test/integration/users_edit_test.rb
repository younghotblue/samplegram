require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              user_name: "",
                                              website: "",
                                              profile: "",
                                              email: "foo@invalid", 
                                              phone_number: "" } }
                                              
    assert_template 'users/edit'
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    user_name = "foo"
    patch user_path(@user), params: { user: { name: name,
                                              user_name: user_name,
                                              website: "",
                                              profile: "Hello",
                                              email: "foo@bar.com", 
                                              phone_number: "09012345678" } }
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal user_name, @user.user_name
  end
end
