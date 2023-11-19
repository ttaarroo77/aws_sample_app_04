# リスト 4.4:Homeページのタイトル確認用にテストを更新する red
# test/controllers/static_pages_controller_test.rb


require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | Ruby on Rails Tutorial Sample App"
  end
end




# リスト 3.24:StaticPagesコントローラのタイトルをテストする red
# test/controllers/static_pages_controller_test.rb

# require 'test_helper'
# class StaticPagesControllerTest < ActionDispatch::IntegrationTest

#   test "should get home" do
#     get static_pages_home_url
#     assert_response :success
#     assert_select "title", "Home | Ruby on Rails Tutorial Sample App"
#   end

#   test "should get help" do
#     get static_pages_help_url
#     assert_response :success
#     assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
#   end

#   test "should get about" do
#     get static_pages_about_url
#     assert_response :success
#     assert_select "title", "About | Ruby on Rails Tutorial Sample App"
#   end
# end


# リスト 3.15:Aboutページのテスト red
# test/controllers/static_pages_controller_test.rb

# require 'test_helper'

# class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
#   test "should get home" do  # static_pages_controller_testにアクセスした時の反応
#     get static_pages_home_url # getリクエストを送りつける  //  送り付け先は、static_pages_home_url  
#     assert_response :success  # 何らかのレスポンスが返ってくるのがsuccess
#   end

#   test "should get help" do
#     get static_pages_help_url  #  getリクエストを送りつける  //  送り付け先は、static_pages_help
#     assert_response :success
#   end

#   test "should get about" do
#     get static_pages_about_url
#     assert_response :success
#   end
# end



# リスト 3.13:StaticPagesコントローラのデフォルトのテスト green
# test/controllers/static_pages_controller_test.rb

# TDT開発：あるべき姿を test で書く
# testしたら、どういう反応が帰ってくるのか？
# コンピュータにファイルの噛み合わせをテストさせるコード

# require 'test_helper'

# class StaticPagesControllerTest < ActionDispatch::IntegrationTest
#   test "should get home" do  # static_pages_controller_testにアクセスした時の反応
#     get static_pages_home_url # getリクエストを送りつける  //  送り付け先は、static_pages_home_url  
#     assert_response :success  # 何らかのレスポンスが返ってくるのがsuccess
#   end

#   test "should get help" do
#     get static_pages_help_url  #  getリクエストを送りつける  //  送り付け先は、static_pages_help
#     assert_response :success
#   end
  
# end
