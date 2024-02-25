# リスト 9.24:log_in_asヘルパーを追加する
# test/test_helper.rb

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?  #  リスト 8.26:テスト中のログインステータスを論理値で返すメソッド
    !session[:user_id].nil?
  end
  
  # リスト 9.24:log_in_asヘルパーを追加 // # テストユーザーとしてログイン
  def log_in_as(user) 
    session[:user_id] = user.id
  end  
end


# リスト 9.24:log_in_asヘルパーを追加 // # テストユーザーとしてログイン
class ActionDispatch::IntegrationTest  
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end



# # リスト 8.26:テスト中のログインステータスを論理値で返すメソッド
# # test/test_helper.rb

# ENV['RAILS_ENV'] ||= 'test'
# require File.expand_path('../../config/environment', __FILE__)
# require 'rails/test_help'

# class ActiveSupport::TestCase
#   # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
#   fixtures :all

#   # テストユーザーがログイン中の場合にtrueを返す
#   def is_logged_in?  #  リスト 8.26:テスト中のログインステータスを論理値で返すメソッド
#     !session[:user_id].nil?
#   end
  
#   # Add more helper methods to be used by all tests here...
# end