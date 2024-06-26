# # リスト 10.62:削除リンクとユーザー削除に対する統合テスト green
# # リスト 10.48:ページネーションを含めたUsersIndexのテスト green
# test/integration/users_index_test.rb

require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  test "index as admin including pagination and delete links" do  # 10.62
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do   # 10.62
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end
  
  #   test "index including pagination" do    # 10.48
  #     log_in_as(@user)
  #     get users_path
  #     assert_template 'users/index'
  #     assert_select 'div.pagination'
  #     User.paginate(page: 1).each do |user|
  #       assert_select 'a[href=?]', user_path(user), text: user.name
  #     end
  #   end


# リスト 10.48:ページネーションを含めたUsersIndexのテスト green
# test/integration/users_index_test.rb
# require 'test_helper'

# class UsersIndexTest < ActionDispatch::IntegrationTest

#   def setup
#     @user = users(:michael)
#   end

#   test "index including pagination" do
#     log_in_as(@user)
#     get users_path
#     assert_template 'users/index'
#     assert_select 'div.pagination'
#     User.paginate(page: 1).each do |user|
#       assert_select 'a[href=?]', user_path(user), text: user.name
#     end
#   end
# end




# # リスト 10.62:削除リンクとユーザー削除に対する統合テスト green
# # リスト 10.48:ページネーションを含めたUsersIndexのテスト green

# test/integration/users_index_test.rb


# require 'test_helper'

# class UsersIndexTest < ActionDispatch::IntegrationTest

#   def setup
#     @admin     = users(:michael)
#     @non_admin = users(:archer)
#   end

#   test "index as admin including pagination and delete links" do
#     log_in_as(@admin)
#     get users_path
#     assert_template 'users/index'
#     assert_select 'div.pagination'
#     first_page_of_users = User.paginate(page: 1)
#     first_page_of_users.each do |user|
#       assert_select 'a[href=?]', user_path(user), text: user.name
#       unless user == @admin
#         assert_select 'a[href=?]', user_path(user), text: 'delete'
#       end
#     end
#     assert_difference 'User.count', -1 do
#       delete user_path(@non_admin)
#     end
#   end

#   test "index as non-admin" do
#     log_in_as(@non_admin)
#     get users_path
#     assert_select 'a', text: 'delete', count: 0
#   end
# end




