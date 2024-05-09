# リスト 9.24:log_in_asヘルパーを追加する
# test/test_helper.rb

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


class ActiveSupport::TestCase
  fixtures :all

  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    # byebug
    !session[:user_id].nil? # 問題点 // 本来はtrue なのにfalse になっている
	 # session[:user_id].present? # 実験版
  end

  # テストユーザーとしてログインする
  def log_in_as(user)
    # byebug
    session[:user_id] = user.id
  end
end


class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_as(user, password: 'password', remember_me: '1')
    # byebug
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end





# リスト 9.24:log_in_asヘルパーを追加する
# test/test_helper.rb

# ENV['RAILS_ENV'] ||= 'test'
# require File.expand_path('../../config/environment', __FILE__)
# require 'rails/test_help'


# class ActiveSupport::TestCase
#   fixtures :all

#   # テストユーザーがログイン中の場合にtrueを返す
#   def is_logged_in?
#     byebug
#     !session[:user_id].nil? #2024-04-28 false になっている
#   end

#   # テストユーザーとしてログインする
#   def log_in_as(user)
#     session[:user_id] = user.id
#   end
# end


# class ActionDispatch::IntegrationTest

#   # テストユーザーとしてログインする
#   def log_in_as(user, password: 'password', remember_me: '1')
#     post login_path, params: { session: { email: user.email,
#                                           password: password,
#                                           remember_me: remember_me } }
#   end
# end



# # リスト8.50:log_in_asヘルパーを追加する
# # test/test_helper.rb

# ENV['RAILS_ENV'] ||= 'test'
# require File.expand_path('../../config/environment', __FILE__)
# require 'rails/test_help'

# class ActiveSupport::TestCase
#   fixtures :all

#   # テストユーザーがログイン中の場合にtrueを返す
#   def is_logged_in?
#     !session[:user_id].nil?
#   end

#   # テストユーザーとしてログインする
#   def log_in_as(user, options = {})
#     password    = options[:password]    || 'password'
#     remember_me = options[:remember_me] || '1'
#     if integration_test?
#       post login_path, session: { email:       user.email,
#                                   password:    password,
#                                   remember_me: remember_me }
#     else
#       session[:user_id] = user.id
#     end
#   end

#   private

#     # 統合テスト内ではtrueを返す
#     def integration_test?
#       defined?(post_via_redirect)
#     end
# end





# 2024-04-28 // #ログ化

# # リスト 9.24:log_in_asヘルパーを追加する
# # test/test_helper.rb


# ENV['RAILS_ENV'] ||= 'test'
# require File.expand_path('../../config/environment', __FILE__)
# require 'rails/test_help'

# class ActiveSupport::TestCase
#   fixtures :all

#   # テストユーザーがログイン中の場合にtrueを返す
#   def is_logged_in?
#     byebug
#     !session[:user_id].nil?
#   end

#   # テストユーザーとしてログインする
#   def log_in_as(user) # 9.24:log_in_asヘルパーを追加
#     # byebug
#     session[:user_id] = user.id
#   end
# end

# class ActionDispatch::IntegrationTest

#   # テストユーザーとしてログインする
#   def log_in_as(user, password: 'password', remember_me: '1')  # 9.24:log_in_asヘルパーを追加
#     post login_path, params: { session: { email: user.email,
#                                           password: password,
#                                           remember_me: remember_me } }
#   end
# end



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