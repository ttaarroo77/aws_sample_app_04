# リスト 8.3:Sessionsコントローラのテストで名前付きルートを使うようにする green
# test/controllers/sessions_controller_test.rb

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get login_path
    assert_response :success
  end
end


# require関数とは
# 標準ライブラリや、gemでインストールしたライブラリ、
# 自分で書いたコードからソースコードを読み込む関数で
# ライブラリに定義されたクラスやメソッドが利用可能に




# require 'test_helper'

# class SessionsControllerTest < ActionDispatch::IntegrationTest
#   test "should get new" do
#     get sessions_new_url
#     assert_response :success
#   end

# end
