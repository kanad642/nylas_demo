require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { connected_email: @user.connected_email, email: @user.email, email_connection_date: @user.email_connection_date, email_provider: @user.email_provider, image: @user.image, name: @user.name, refresh_token: @user.refresh_token, uid: @user.uid } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { connected_email: @user.connected_email, email: @user.email, email_connection_date: @user.email_connection_date, email_provider: @user.email_provider, image: @user.image, name: @user.name, refresh_token: @user.refresh_token, uid: @user.uid } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
