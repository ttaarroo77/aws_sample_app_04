# リスト 13.54:間違ったユーザーによるマイクロポスト削除に対してテストする green
# リスト 13.31:Micropostsコントローラの認可テスト red
# test/controllers/microposts_controller_test.rb

# require 'test_helper'

# class MicropostsControllerTest < ActionDispatch::IntegrationTest
#   def setup
#     @micropost = microposts(:orange)
#   end

#   test "should redirect create when not logged in" do    # 13.31
#     assert_no_difference 'Micropost.count' do
#       post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
#     end
#     assert_redirected_to login_url
#   end

#   test "should redirect destroy when not logged in" do    # 13.31
#     assert_no_difference 'Micropost.count' do
#       delete micropost_path(@micropost)
#     end
#     assert_redirected_to login_url
#   end

#   test "should redirect destroy for wrong micropost" do    # 13.54
#     log_in_as(users(:michael))
#     micropost = microposts(:ants)
#     assert_no_difference 'Micropost.count' do
#       delete micropost_path(micropost)
#     end
#     assert_redirected_to root_url
#   end
# end
