# リスト 10.61:管理者権限の制御をアクションレベルでテストする green
# リスト 10.34:indexアクションのリダイレクトをテストする red
# リスト 10.24:間違ったユーザーが編集しようとしたときのテスト red
# リスト 10.20:editとupdateアクションの保護に対するテストする red

# test/controllers/users_controller_test.rb

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user       = users(:michael)
    @other_user = users(:archer)  # 10.24:
  end

  test "should redirect edit when not logged in" do  # 10.20:
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do   # 10.20:
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end


  test "should redirect edit when logged in as wrong user" do    # 10.24:
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url # ココがエラーになる
  end
  test "should redirect update when logged in as wrong user" do # 10.24:
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty? # ココがエラーになる
    assert_redirected_to root_url
  end
  
  test "should redirect index when not logged in" do   # 10.34:
    get users_path
    assert_redirected_to login_url
  end  
  
  test "should redirect destroy when not logged in" do     # 10.61
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do     # 10.61
    log_in_as(@other_user)
    assert_no_difference 'User.count' do # ココがエラーになる
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
  
end





# リスト 5.44:Usersコントローラのテストで名前付きルートを使うようにする green
# test/controllers/users_controller_test.rb

# require 'test_helper'

# class UsersControllerTest < ActionDispatch::IntegrationTest

#   test "should get new" do
#     # new アクションの結果をテストしている
#     get signup_path
#     assert_response :success
#   end
# end



# require 'test_helper'

# class UsersControllerTest < ActionDispatch::IntegrationTest
#   test "should get new" do
#     get users_new_url
#     assert_response :success
#   end

# end
