# リスト 10.29:フレンドリーフォワーディングのテスト red
# リスト 10.17:テストユーザーでログインする green
# リスト 10.11:編集の成功に対するテスト red
# リスト 10.9:編集の失敗に対するテスト green
# test/integration/users_edit_test.rb



require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup  
    @user = users(:michael)     #  10.9
  end

  test "unsuccessful edit" do     #  10.9
    log_in_as(@user)  # 10.17:
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end
  
  test "successful edit" do   # 10.11
    log_in_as(@user)  # 10.17:
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do  # 10.29
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

end






# リスト 10.29:フレンドリーフォワーディングのテスト red
# リスト 10.17:テストユーザーでログインする green
# リスト 10.11:編集の成功に対するテスト red
# リスト 10.9:編集の失敗に対するテスト green
# test/integration/users_edit_test.rb






# require 'test_helper'

# class UsersEditTest < ActionDispatch::IntegrationTest

#   def setup  
#     @user = users(:michael)     #  10.9
#   end

#   test "unsuccessful edit" do     #  10.9
#     log_in_as(@user)  # 10.17:
#     get edit_user_path(@user)
#     assert_template 'users/edit'
#     patch user_path(@user), params: { user: { name:  "",
#                                               email: "foo@invalid",
#                                               password:              "foo",
#                                               password_confirmation: "bar" } }

#     assert_template 'users/edit'
#   end
  
#   test "successful edit" do   # 10.11
#     log_in_as(@user)  # 10.17:
#     get edit_user_path(@user)
#     assert_template 'users/edit'
#     name  = "Foo Bar"
#     email = "foo@bar.com"
#     patch user_path(@user), params: { user: { name:  name,
#                                               email: email,
#                                               password:              "",
#                                               password_confirmation: "" } }
#     assert_not flash.empty?
#     assert_redirected_to @user
#     @user.reload
#     assert_equal name,  @user.name
#     assert_equal email, @user.email
#   end

#   test "successful edit with friendly forwarding" do  # 10.29
#     get edit_user_path(@user)
#     log_in_as(@user)
#     assert_redirected_to edit_user_url(@user)
#     name  = "Foo Bar"
#     email = "foo@bar.com"
#     patch user_path(@user), params: { user: { name:  name,
#                                               email: email,
#                                               password:              "",
#                                               password_confirmation: "" } }
#     assert_not flash.empty?
#     assert_redirected_to @user
#     @user.reload
#     assert_equal name,  @user.name
#     assert_equal email, @user.email
#   end

# end



# リスト 10.29:フレンドリーフォワーディングのテスト red
# リスト 10.17:テストユーザーでログインする green
# リスト 10.11:編集の成功に対するテスト red
# リスト 10.9:編集の失敗に対するテスト green
# test/integration/users_edit_test.rb

# require 'test_helper'

# class UsersEditTest < ActionDispatch::IntegrationTest

#   def setup
#     @user = users(:michael)
#   end

#   test "unsuccessful edit" do    # リスト 10.9:編集の失敗に対するテスト green
#     log_in_as(@user)    # リスト 10.17:テストユーザーでログインする green
#     get edit_user_path(@user)
#     assert_template 'users/edit'
#     patch user_path(@user), params: { user: { name:  "",
#                                               email: "foo@invalid",
#                                               password:              "foo",
#                                               password_confirmation: "bar" } }

#     assert_template 'users/edit'
#   end  

#   test "successful edit" do  # リスト 10.11:編集の成功に対するテスト red
#     log_in_as(@user)    # リスト 10.17:テストユーザーでログインする green
#     get edit_user_path(@user)
#     assert_template 'users/edit'
#     name  = "Foo Bar"
#     email = "foo@bar.com"
#     patch user_path(@user), params: { user: { name:  name,
#                                               email: email,
#                                               password:              "",
#                                               password_confirmation: "" } }
#     assert_not flash.empty?
#     assert_redirected_to @user
#     @user.reload
#     assert_equal name,  @user.name
#     assert_equal email, @user.email
#   end

  
#   test "successful edit with friendly forwarding" do  # リスト 10.29:フレンドリーフォワーディングのテスト red  
#     get edit_user_path(@user)  # リスト 10.29:フレンドリーフォワーディングのテスト red  
#     log_in_as(@user)  # リスト 10.29:フレンドリーフォワーディングのテスト red  
#     assert_redirected_to edit_user_url(@user)  # リスト 10.29:フレンドリーフォワーディングのテスト red  
#     name  = "Foo Bar"
#     email = "foo@bar.com"
#     patch user_path(@user), params: { user: { name:  name,
#                                               email: email,
#                                               password:              "",
#                                               password_confirmation: "" } }
#     assert_not flash.empty?
#     assert_redirected_to @user
#     @user.reload
#     assert_equal name,  @user.name
#     assert_equal email, @user.email
#   end
# end


# require 'test_helper'

# class UsersEditTest < ActionDispatch::IntegrationTest
#   # test "the truth" do
#   #   assert true
#   # end
# end
