# リスト 8.26:テスト中のログインステータスを論理値で返すメソッド
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
  
  # Add more helper methods to be used by all tests here...
end