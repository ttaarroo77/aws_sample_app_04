# リスト 5.44:Usersコントローラのテストで名前付きルートを使うようにする green
# test/controllers/users_controller_test.rb

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    # new アクションの結果をテストしている
    get signup_path
    assert_response :success
  end
end



# require 'test_helper'

# class UsersControllerTest < ActionDispatch::IntegrationTest
#   test "should get new" do
#     get users_new_url
#     assert_response :success
#   end

# end
