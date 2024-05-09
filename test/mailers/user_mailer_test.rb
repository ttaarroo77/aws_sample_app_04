# リスト 12.12: パスワード再設定用メイラーメソッドのテストを追加する green
# test/mailers/user_mailer_test.rb

require 'test_helper'
class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    # assert_equal ["noreply@example.com"], mail.from
    assert_equal ["from@example.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end


# # 2024-03-17 暫定的に消す。
# # # 12.23 heroku 非対応
#   test "password_reset" do
#     user = users(:michael)
#     user.reset_token = User.new_token   # 12.12:
#     mail = UserMailer.password_reset(user)
#     assert_equal "Password reset", mail.subject
#     assert_equal [user.email], mail.to
#     # assert_equal ["noreply@example.com"], mail.from
#     assert_equal ["from@example.com"], mail.from
    
#     assert_match user.reset_token,        mail.body.encoded
#     assert_match CGI.escape(user.email),  mail.body.encoded
#   end
  
end



# require 'test_helper'

# class UserMailerTest < ActionMailer::TestCase
#   test "account_activation" do
#     mail = UserMailer.account_activation
#     assert_equal "Account activation", mail.subject
#     assert_equal ["to@example.org"], mail.to
#     assert_equal ["from@example.com"], mail.from
#     assert_match "Hi", mail.body.encoded
#   end

#   test "password_reset" do
#     mail = UserMailer.password_reset
#     assert_equal "Password reset", mail.subject
#     assert_equal ["to@example.org"], mail.to
#     assert_equal ["from@example.com"], mail.from
#     assert_match "Hi", mail.body.encoded
#   end

# end
