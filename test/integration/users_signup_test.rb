# リスト 8.27:ユーザー登録後のログインのテスト green
# test/integration/users_signup_test.rb


require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do  # リスト 7.23:無効なユーザー登録に対するテスト green
    get signup_path
    assert_no_difference 'User.count' do # User.count に変動がないか、調べるテスト
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'  # assert_templateメソッド： 正しいテンプレートとレイアウトを描画してるか検証
                              # 送信に失敗した時、newアクションが再描画されるはず
  end

  
  test "valid signup information" do  # リスト 7.33:有効なユーザー登録に対するテスト green
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!  # リダイレクト先にアクセス // よく分かってない
    assert_template 'users/show'  # assert_templateメソッド： 正しいテンプレートとレイアウトを描画してるか検証
                              # 送信に失敗した時、newアクションが再描画されるはず
    assert is_logged_in?    # リスト 8.27:ユーザー登録後のログインのテスト green 
  end

end



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