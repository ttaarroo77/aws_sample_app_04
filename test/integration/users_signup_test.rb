# リスト 11.33:ユーザー登録のテストにアカウント有効化を追加する green
# test/integration/users_signup_test.rb

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information with account activation" do
    get signup_path
    # byebug
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    # byebug
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    # byebug
    assert_not user.activated?
    # byebug
    # 有効化していない状態でログインしてみる
    log_in_as(user)

# rails test /home/ec2-user/environment/sample_app.12_01/test/integration/users_signup_test.rb:43
    # デバッグ用に byebug を挿入する
    # byebug
    
    assert_not is_logged_in? #2024-04-28 ここに問題がある
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: user.email)

    
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # 有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end


# require 'test_helper'

# class UsersSignupTest < ActionDispatch::IntegrationTest

#   def setup
#     ActionMailer::Base.deliveries.clear
#   end

#   test "invalid signup information" do
#     get signup_path
#     assert_no_difference 'User.count' do
#       post users_path, params: { user: { name:  "",
#                                         email: "user@invalid",
#                                         password:              "foo",
#                                         password_confirmation: "bar" } }
#     end
#     assert_template 'users/new'
#     assert_select 'div#error_explanation'
#     assert_select 'div.field_with_errors'
#   end

#   test "valid signup information with account activation" do
#     get signup_path
#     assert_difference 'User.count', 1 do
#       post users_path, params: { user: { name:  "Example User",
#                                         email: "user@example.com",
#                                         password:              "password",
#                                         password_confirmation: "password" } }
#     end
#     assert_equal 1, ActionMailer::Base.deliveries.size
#     user = assigns(:user)
#     assert_not user.activated?
#     # 有効化していない状態でログインしてみる
#     log_in_as(user)
#     assert_not is_logged_in?
#     # 有効化トークンが不正な場合
#     get edit_account_activation_path("invalid token", email: user.email)
#     assert_not is_logged_in?
#     # トークンは正しいがメールアドレスが無効な場合
#     get edit_account_activation_path(user.activation_token, email: 'wrong')
#     assert_not is_logged_in?
#     # 有効化トークンが正しい場合
#     get edit_account_activation_path(user.activation_token, email: user.email)
#     assert user.reload.activated?
#     follow_redirect!
#     assert_template 'users/show'
#     assert is_logged_in?
#   end
# end



# # リスト 8.27:ユーザー登録後のログインのテスト green
# # test/integration/users_signup_test.rb


# require 'test_helper'

# class UsersSignupTest < ActionDispatch::IntegrationTest

#   test "invalid signup information" do  # リスト 7.23:無効なユーザー登録に対するテスト green
#     get signup_path
#     assert_no_difference 'User.count' do # User.count に変動がないか、調べるテスト
#       post users_path, params: { user: { name:  "",
#                                         email: "user@invalid",
#                                         password:              "foo",
#                                         password_confirmation: "bar" } }
#     end
#     assert_template 'users/new'  # assert_templateメソッド： 正しいテンプレートとレイアウトを描画してるか検証
#                               # 送信に失敗した時、newアクションが再描画されるはず
#   end

  
#   test "valid signup information" do  # リスト 7.33:有効なユーザー登録に対するテスト green
#     get signup_path
#     assert_difference 'User.count', 1 do
#       post users_path, params: { user: { name:  "Example User",
#                                         email: "user@example.com",
#                                         password:              "password",
#                                         password_confirmation: "password" } }
#     end
#     follow_redirect!  # リダイレクト先にアクセス // よく分かってない
#     assert_template 'users/show'  # assert_templateメソッド： 正しいテンプレートとレイアウトを描画してるか検証
#                               # 送信に失敗した時、newアクションが再描画されるはず
#     assert is_logged_in?    # リスト 8.27:ユーザー登録後のログインのテスト green 
#   end

# end



# ------------------------------------------------------------------------------------------


# # test/integration/users_signup_test.rb
# # リスト 7.23:無効なユーザー登録に対するテスト green
# # リスト 7.33:有効なユーザー登録に対するテスト green


# require 'test_helper'

# class UsersSignupTest < ActionDispatch::IntegrationTest

#   test "invalid signup information" do  # リスト 7.23:無効なユーザー登録に対するテスト green
#     get signup_path
#     assert_no_difference 'User.count' do # User.count に変動がないか、調べるテスト
#       post users_path, params: { user: { name:  "",
#                                         email: "user@invalid",
#                                         password:              "foo",
#                                         password_confirmation: "bar" } }
#     end
#     assert_template 'users/new'  # assert_templateメソッド： 正しいテンプレートとレイアウトを描画してるか検証
#                               # 送信に失敗した時、newアクションが再描画されるはず
#   end

  
#   test "valid signup information" do  # リスト 7.33:有効なユーザー登録に対するテスト green
#     get signup_path
#     assert_difference 'User.count', 1 do
#       post users_path, params: { user: { name:  "Example User",
#                                         email: "user@example.com",
#                                         password:              "password",
#                                         password_confirmation: "password" } }
#     end
#     follow_redirect!  # リダイレクト先にアクセス // よく分かってない
#     assert_template 'users/show'  # assert_templateメソッド： 正しいテンプレートとレイアウトを描画してるか検証
#                               # 送信に失敗した時、newアクションが再描画されるはず
                              
#   end
  
# end


# 以下のコマンドは、rails routes で意味が分かる。
# getリクエスト、postリクエストなど、
    # get signup_path
    # post users_path


# assert_no_diffrence などは、以下URLを参考
# https://jyu2log.com/rails-test




# リスト 7.23:無効なユーザー登録に対するテスト green

# require 'test_helper'

# class UsersSignupTest < ActionDispatch::IntegrationTest

#   test "invalid signup information" do
#     get signup_path
#     assert_no_difference 'User.count' do
#       post users_path, params: { user: { name:  "",
#                                         email: "user@invalid",
#                                         password:              "foo",
#                                         password_confirmation: "bar" } }
#     end
#     assert_template 'users/new'
#   end
# end


# require 'test_helper'

# class UsersSignupTest < ActionDispatch::IntegrationTest
#   # test "the truth" do
#   #   assert true
#   # end
# end