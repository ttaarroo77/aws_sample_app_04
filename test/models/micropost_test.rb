# リスト 13.14:マイクロポストの順序付けをテストする
# リスト 13.12:慣習的に正しくマイクロポストを作成する green
# リスト 13.7:Micropostモデルのバリデーションに対するテスト red
# リスト 13.4:新しいMicropostの有効性に対するテスト green
# test/models/micropost_test.rb


# require 'test_helper'
# class MicropostTest < ActiveSupport::TestCase

#   def setup
#     @user = users(:michael)
#   @micropost = @user.microposts.build(content: "Lorem ipsum")   # 13.12
#     @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)	    # 13.4
#   end

#   test "should be valid" do
#     assert @micropost.valid?
#   end

#   test "user id should be present" do
#     @micropost.user_id = nil
#     assert_not @micropost.valid?
#   end

#   test "content should be present" do     # 13.7
#     @micropost.content = "   "
#     assert_not @micropost.valid?
#   end

#   test "content should be at most 140 characters" do    # 13.7
#     @micropost.content = "a" * 141
#     assert_not @micropost.valid?
#   end

#   test "order should be most recent first" do    # 13.14
#     assert_equal microposts(:most_recent), Micropost.first
#   end
# end


# リスト 13.4:新しいMicropostの有効性に対するテスト green
# test/models/micropost_test.rb

# require 'test_helper'

# class MicropostTest < ActiveSupport::TestCase

#   def setup
#     @user = users(:michael)
#     # このコードは慣習的に正しくない
#     @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
#   end

#   test "should be valid" do
#     assert @micropost.valid?
#   end

#   test "user id should be present" do
#     @micropost.user_id = nil
#     assert_not @micropost.valid?
#   end
# end


# require 'test_helper'

# class MicropostTest < ActiveSupport::TestCase
#   # test "the truth" do
#   #   assert true
#   # end
# end
