# リスト 9.25:[remember me] チェックボックスのテスト green
# test/integration/users_login_test.rb

# リスト 9.14:ユーザーログアウトのテスト red


require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup    # リスト 8.23:有効な情報を使ってユーザーログインをテストする green
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information followed by logout" do    # # リスト 8.31:ユーザーログアウトのテスト green
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path  # 9.14 2番目のウィンドウでログアウトをクリックするユーザーをシミュレート
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
  

 # 9.25:[remember me] チェックボックスのテスト

  test "login with remembering" do # 9.25:[remember me] チェックボックスのテスト 
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do  # 9.25:[remember me] チェックボックスのテスト
    # クッキーを保存してログイン
    log_in_as(@user, remember_me: '1')
    delete logout_path
    # クッキーを削除してログイン
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
  
end




# リスト 8.31:ユーザーログアウトのテスト green
# test/integration/users_login_test.rb


# require 'test_helper'

# class UsersLoginTest < ActionDispatch::IntegrationTest

#   def setup    # リスト 8.23:有効な情報を使ってユーザーログインをテストする green
#     @user = users(:michael)
#   end

#   test "login with invalid information" do
#     get login_path
#     assert_template 'sessions/new'
#     post login_path, params: { session: { email: "", password: "" } }
#     assert_template 'sessions/new'
#     assert_not flash.empty?
#     get root_path
#     assert flash.empty?
#   end
  
#   test "login with valid information followed by logout" do    # # リスト 8.31:ユーザーログアウトのテスト green
#     get login_path
#     post login_path, params: { session: { email:    @user.email,
#                                           password: 'password' } }
#     assert is_logged_in?
#     assert_redirected_to @user
#     follow_redirect!
#     assert_template 'users/show'
#     assert_select "a[href=?]", login_path, count: 0
#     assert_select "a[href=?]", logout_path
#     assert_select "a[href=?]", user_path(@user)
#     delete logout_path
#     assert_not is_logged_in?
#     assert_redirected_to root_url
#     follow_redirect!
#     assert_select "a[href=?]", login_path
#     assert_select "a[href=?]", logout_path,      count: 0
#     assert_select "a[href=?]", user_path(@user), count: 0
#   end  
  
# end




# # リスト 8.23:有効な情報を使ってユーザーログインをテストする green
# # test/integration/users_login_test.rb

# require 'test_helper'

# class UsersLoginTest < ActionDispatch::IntegrationTest

#   def setup    # リスト 8.23:有効な情報を使ってユーザーログインをテストする green
#     @user = users(:michael)
#   end

#   test "login with invalid information" do
#     get login_path
#     assert_template 'sessions/new'
#     post login_path, params: { session: { email: "", password: "" } }
#     assert_template 'sessions/new'
#     assert_not flash.empty?
#     get root_path
#     assert flash.empty?
#   end
# end




# # リスト 8.9:フラッシュメッセージの残留をキャッチするテスト red
# # test/integration/users_login_test.rb

# require 'test_helper'

# class UsersLoginTest < ActionDispatch::IntegrationTest

#   test "login with invalid information" do
#     get login_path
#     assert_template 'sessions/new'
#     post login_path, params: { session: { email: "", password: "" } }
#     assert_template 'sessions/new'
#     assert_not flash.empty?
#     get root_path
#     assert flash.empty?
#   end
# end


# リスト 8.9:フラッシュメッセージの残留をキャッチするテスト red
# test/integration/users_login_test.rb

# require 'test_helper'

# class UsersLoginTest < ActionDispatch::IntegrationTest

#   test "login with invalid information" do
#     get login_path
#     assert_template 'sessions/new'
#     post login_path, params: { session: { email: "", password: "" } }
#     assert_template 'sessions/new'
#     assert_not flash.empty?
#     get root_path
#     assert flash.empty?
#   end
# end




# require 'test_helper'

# class UsersLoginTest < ActionDispatch::IntegrationTest
#   # test "the truth" do
#   #   assert true
#   # end
# end
