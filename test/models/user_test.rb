# リスト 6.41:パスワードの最小文字数をテストする red
# test/models/user_test.rb


require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup 
    @user = User.new(name: "Example User", email: "user@example.com")
  end
  
  def setup #@userはインスタンス変数ですが、setupメソッド内で宣言すれば、すべてのテスト内でこのインスタンス変数が使えます。
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar") #リスト 6.39:パスワードとパスワード確認を追加する green
  end  

  test "should be valid" do
    assert @user.valid?
  end

# リスト 6.5:有効なUserかどうかをテストする green
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

# # リスト 6.11:email属性の検証に対するテスト red
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

# リスト 6.14:nameの長さの検証に対するテスト red
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

# リスト 6.18:有効なメールフォーマットをテストする green  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end  

# リスト 6.19:メールフォーマットの検証に対するテスト red
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

# リスト 6.26:大文字小文字を区別しない、一意性のテスト red
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase # リスト 6.26:大文字小文字を区別しない、一意性のテスト red
    @user.save
    assert_not duplicate_user.valid?
  end

# リスト 6.41:パスワードの最小文字数をテストする red
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  # リスト 9.17:ダイジェストが存在しない場合のauthenticated?のテスト red  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end  
  
end



# # リスト 6.41:パスワードの最小文字数をテストする red
# # test/models/user_test.rb


# require 'test_helper'

# class UserTest < ActiveSupport::TestCase

#   def setup 
#     @user = User.new(name: "Example User", email: "user@example.com")
#   end
  
#   def setup #@userはインスタンス変数ですが、setupメソッド内で宣言すれば、すべてのテスト内でこのインスタンス変数が使えます。
#     @user = User.new(name: "Example User", email: "user@example.com",
#                     password: "foobar", password_confirmation: "foobar") #リスト 6.39:パスワードとパスワード確認を追加する green
#   end  

#   test "should be valid" do
#     assert @user.valid?
#   end

# # リスト 6.5:有効なUserかどうかをテストする green
#   test "name should be present" do
#     @user.name = ""
#     assert_not @user.valid?
#   end

# # # リスト 6.11:email属性の検証に対するテスト red
#   test "email should be present" do
#     @user.email = "     "
#     assert_not @user.valid?
#   end

# # リスト 6.14:nameの長さの検証に対するテスト red
#   test "name should not be too long" do
#     @user.name = "a" * 51
#     assert_not @user.valid?
#   end

#   test "email should not be too long" do
#     @user.email = "a" * 244 + "@example.com"
#     assert_not @user.valid?
#   end

# # リスト 6.18:有効なメールフォーマットをテストする green  
#   test "email validation should accept valid addresses" do
#     valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
#                         first.last@foo.jp alice+bob@baz.cn]
#     valid_addresses.each do |valid_address|
#       @user.email = valid_address
#       assert @user.valid?, "#{valid_address.inspect} should be valid"
#     end
#   end  

# # リスト 6.19:メールフォーマットの検証に対するテスト red
#   test "email validation should reject invalid addresses" do
#     invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
#                           foo@bar_baz.com foo@bar+baz.com]
#     invalid_addresses.each do |invalid_address|
#       @user.email = invalid_address
#       assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
#     end
#   end

# # リスト 6.26:大文字小文字を区別しない、一意性のテスト red
#   test "email addresses should be unique" do
#     duplicate_user = @user.dup
#     duplicate_user.email = @user.email.upcase # リスト 6.26:大文字小文字を区別しない、一意性のテスト red
#     @user.save
#     assert_not duplicate_user.valid?
#   end

# # リスト 6.41:パスワードの最小文字数をテストする red
#   test "password should be present (nonblank)" do
#     @user.password = @user.password_confirmation = " " * 6
#     assert_not @user.valid?
#   end

#   test "password should have a minimum length" do
#     @user.password = @user.password_confirmation = "a" * 5
#     assert_not @user.valid?
#   end
  
# end



# # リスト 6.39:パスワードとパスワード確認を追加する green
# # test/models/user_test.rb


# require 'test_helper'

# class UserTest < ActiveSupport::TestCase

#   def setup 
#     @user = User.new(name: "Example User", email: "user@example.com")
#   end
  
#   def setup #@userはインスタンス変数ですが、setupメソッド内で宣言すれば、すべてのテスト内でこのインスタンス変数が使えます。
#     @user = User.new(name: "Example User", email: "user@example.com",
#                     password: "foobar", password_confirmation: "foobar") #リスト 6.39:パスワードとパスワード確認を追加する green
#   end  

#   test "should be valid" do
#     assert @user.valid?
#   end

# # リスト 6.5:有効なUserかどうかをテストする green
#   test "name should be present" do
#     @user.name = ""
#     assert_not @user.valid?
#   end

# # # リスト 6.11:email属性の検証に対するテスト red
#   test "email should be present" do
#     @user.email = "     "
#     assert_not @user.valid?
#   end

# # リスト 6.14:nameの長さの検証に対するテスト red
#   test "name should not be too long" do
#     @user.name = "a" * 51
#     assert_not @user.valid?
#   end

#   test "email should not be too long" do
#     @user.email = "a" * 244 + "@example.com"
#     assert_not @user.valid?
#   end

# # リスト 6.18:有効なメールフォーマットをテストする green  
#   test "email validation should accept valid addresses" do
#     valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
#                         first.last@foo.jp alice+bob@baz.cn]
#     valid_addresses.each do |valid_address|
#       @user.email = valid_address
#       assert @user.valid?, "#{valid_address.inspect} should be valid"
#     end
#   end  

# # リスト 6.19:メールフォーマットの検証に対するテスト red
#   test "email validation should reject invalid addresses" do
#     invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
#                           foo@bar_baz.com foo@bar+baz.com]
#     invalid_addresses.each do |invalid_address|
#       @user.email = invalid_address
#       assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
#     end
#   end

# # リスト 6.26:大文字小文字を区別しない、一意性のテスト red
#   test "email addresses should be unique" do
#     duplicate_user = @user.dup
#     duplicate_user.email = @user.email.upcase # リスト 6.26:大文字小文字を区別しない、一意性のテスト red
#     @user.save
#     assert_not duplicate_user.valid?
#   end
  
# end





# # リスト 6.26:大文字小文字を区別しない、一意性のテスト red
# # test/models/user_test.rb


# require 'test_helper'

# class UserTest < ActiveSupport::TestCase

#   def setup #@userはインスタンス変数ですが、setupメソッド内で宣言すれば、すべてのテスト内でこのインスタンス変数が使えます。
#     @user = User.new(name: "Example User", email: "user@example.com")
#   end

#   test "should be valid" do
#     assert @user.valid?
#   end

# # リスト 6.5:有効なUserかどうかをテストする green
#   test "name should be present" do
#     @user.name = ""
#     assert_not @user.valid?
#   end

# # # リスト 6.11:email属性の検証に対するテスト red
#   test "email should be present" do
#     @user.email = "     "
#     assert_not @user.valid?
#   end

# # リスト 6.14:nameの長さの検証に対するテスト red
#   test "name should not be too long" do
#     @user.name = "a" * 51
#     assert_not @user.valid?
#   end

#   test "email should not be too long" do
#     @user.email = "a" * 244 + "@example.com"
#     assert_not @user.valid?
#   end

# # リスト 6.18:有効なメールフォーマットをテストする green  
#   test "email validation should accept valid addresses" do
#     valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
#                         first.last@foo.jp alice+bob@baz.cn]
#     valid_addresses.each do |valid_address|
#       @user.email = valid_address
#       assert @user.valid?, "#{valid_address.inspect} should be valid"
#     end
#   end  

# # リスト 6.19:メールフォーマットの検証に対するテスト red
#   test "email validation should reject invalid addresses" do
#     invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
#                           foo@bar_baz.com foo@bar+baz.com]
#     invalid_addresses.each do |invalid_address|
#       @user.email = invalid_address
#       assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
#     end
#   end

# # リスト 6.26:大文字小文字を区別しない、一意性のテスト red
#   test "email addresses should be unique" do
#     duplicate_user = @user.dup
#     duplicate_user.email = @user.email.upcase # リスト 6.26:大文字小文字を区別しない、一意性のテスト red
#     @user.save
#     assert_not duplicate_user.valid?
#   end
  
# end






# リスト 6.24:重複するメールアドレス拒否のテスト red
# test/models/user_test.rb

# require 'test_helper'

# class UserTest < ActiveSupport::TestCase

#   def setup #@userはインスタンス変数ですが、setupメソッド内で宣言すれば、すべてのテスト内でこのインスタンス変数が使えます。
#     @user = User.new(name: "Example User", email: "user@example.com")
#   end

#   test "should be valid" do
#     assert @user.valid?
#   end

# # リスト 6.5:有効なUserかどうかをテストする green
#   test "name should be present" do
#     @user.name = ""
#     assert_not @user.valid?
#   end

# # # リスト 6.11:email属性の検証に対するテスト red
#   test "email should be present" do
#     @user.email = "     "
#     assert_not @user.valid?
#   end

# # リスト 6.14:nameの長さの検証に対するテスト red
#   test "name should not be too long" do
#     @user.name = "a" * 51
#     assert_not @user.valid?
#   end

#   test "email should not be too long" do
#     @user.email = "a" * 244 + "@example.com"
#     assert_not @user.valid?
#   end

# # リスト 6.18:有効なメールフォーマットをテストする green  
#   test "email validation should accept valid addresses" do
#     valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
#                         first.last@foo.jp alice+bob@baz.cn]
#     valid_addresses.each do |valid_address|
#       @user.email = valid_address
#       assert @user.valid?, "#{valid_address.inspect} should be valid"
#     end
#   end  

# # リスト 6.19:メールフォーマットの検証に対するテスト red
#   test "email validation should reject invalid addresses" do
#     invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
#                           foo@bar_baz.com foo@bar+baz.com]
#     invalid_addresses.each do |invalid_address|
#       @user.email = invalid_address
#       assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
#     end
#   end

# # リスト 6.24:重複するメールアドレス拒否のテスト red
#   test "email addresses should be unique" do
#     duplicate_user = @user.dup
#     @user.save
#     assert_not duplicate_user.valid?
#   end
  
# end




# # リスト 6.19:メールフォーマットの検証に対するテスト red
# # test/models/user_test.rb

# require 'test_helper'

# class UserTest < ActiveSupport::TestCase

#   def setup #@userはインスタンス変数ですが、setupメソッド内で宣言すれば、すべてのテスト内でこのインスタンス変数が使えます。
#     @user = User.new(name: "Example User", email: "user@example.com")
#   end

#   test "should be valid" do
#     assert @user.valid?
#   end

# # リスト 6.5:有効なUserかどうかをテストする green
#   test "name should be present" do
#     @user.name = ""
#     assert_not @user.valid?
#   end

# # # リスト 6.11:email属性の検証に対するテスト red
#   test "email should be present" do
#     @user.email = "     "
#     assert_not @user.valid?
#   end

# # リスト 6.14:nameの長さの検証に対するテスト red
#   test "name should not be too long" do
#     @user.name = "a" * 51
#     assert_not @user.valid?
#   end

#   test "email should not be too long" do
#     @user.email = "a" * 244 + "@example.com"
#     assert_not @user.valid?
#   end

# # リスト 6.18:有効なメールフォーマットをテストする green  
#   test "email validation should accept valid addresses" do
#     valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
#                         first.last@foo.jp alice+bob@baz.cn]
#     valid_addresses.each do |valid_address|
#       @user.email = valid_address
#       assert @user.valid?, "#{valid_address.inspect} should be valid"
#     end
#   end  

# # リスト 6.19:メールフォーマットの検証に対するテスト red
#   test "email validation should reject invalid addresses" do
#     invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
#                           foo@bar_baz.com foo@bar+baz.com]
#     invalid_addresses.each do |invalid_address|
#       @user.email = invalid_address
#       assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
#     end
#   end
  
# end



# # リスト 6.18:有効なメールフォーマットをテストする green
# # test/models/user_test.rb

# require 'test_helper'

# class UserTest < ActiveSupport::TestCase

#   def setup #@userはインスタンス変数ですが、setupメソッド内で宣言すれば、すべてのテスト内でこのインスタンス変数が使えます。
#     @user = User.new(name: "Example User", email: "user@example.com")
#   end

#   test "should be valid" do
#     assert @user.valid?
#   end

# # リスト 6.5:有効なUserかどうかをテストする green
#   test "name should be present" do
#     @user.name = ""
#     assert_not @user.valid?
#   end

# # # リスト 6.11:email属性の検証に対するテスト red
#   test "email should be present" do
#     @user.email = "     "
#     assert_not @user.valid?
#   end

# # リスト 6.14:nameの長さの検証に対するテスト red
#   test "name should not be too long" do
#     @user.name = "a" * 51
#     assert_not @user.valid?
#   end

#   test "email should not be too long" do
#     @user.email = "a" * 244 + "@example.com"
#     assert_not @user.valid?
#   end

# # リスト 6.18:有効なメールフォーマットをテストする green  
#   test "email validation should accept valid addresses" do
#     valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
#                         first.last@foo.jp alice+bob@baz.cn]
#     valid_addresses.each do |valid_address|
#       @user.email = valid_address
#       assert @user.valid?, "#{valid_address.inspect} should be valid"
#     end
#   end  
  
# end



# リスト 6.14:nameの長さの検証に対するテスト red
# test/models/user_test.rb

# require 'test_helper'

# class UserTest < ActiveSupport::TestCase

#   def setup
#     @user = User.new(name: "Example User", email: "user@example.com")
#   end

#   test "should be valid" do
#     assert @user.valid?
#   end

#   test "name should be present" do
#     @user.name = ""
#     assert_not @user.valid?
#   end

#   test "email should be present" do
#     @user.email = "     "
#     assert_not @user.valid?
#   end

# # リスト 6.14:nameの長さの検証に対するテスト red
#   test "name should not be too long" do
#     @user.name = "a" * 51
#     assert_not @user.valid?
#   end

#   test "email should not be too long" do
#     @user.email = "a" * 244 + "@example.com"
#     assert_not @user.valid?
#   end
  
# end





# # リスト 6.11:email属性の検証に対するテスト red
# # test/models/user_test.rb

# require 'test_helper'

# class UserTest < ActiveSupport::TestCase

#   def setup
#     @user = User.new(name: "Example User", email: "user@example.com")
#   end

#   test "should be valid" do
#     assert @user.valid?
#   end

#   test "name should be present" do
#     @user.name = ""
#     assert_not @user.valid?
#   end

# # リスト 6.11:email属性の検証に対するテスト red
#   test "email should be present" do
#     @user.email = "     "
#     assert_not @user.valid?
#   end
# end




# リスト 6.7:name属性にバリデーションに対するテスト red
# test/models/user_test.rb

# require 'test_helper'

# class UserTest < ActiveSupport::TestCase

#   def setup
#     @user = User.new(name: "Example User", email: "user@example.com")
#   end

#   test "should be valid" do
#     assert @user.valid?
#   end

# リスト 6.5:有効なUserかどうかをテストする green
#   test "name should be present" do
#     @user.name = "     "
#     assert_not @user.valid?
#   end
# end



# リスト 6.5:有効なUserかどうかをテストする green
# test/models/user_test.rb


# require 'test_helper'

# class UserTest < ActiveSupport::TestCase

#   def setup
#     @user = User.new(name: "Example User", email: "user@example.com")
#   end

# setupメソッド内に書かれた処理は、各テストが走る直前に実行されます。
# @userはインスタンス変数ですが、setupメソッド内で宣言しておけば、
# すべてのテスト内でこのインスタンス変数が使えるようになります。

# リスト 6.5:有効なUserかどうかをテストする green
#   test "should be valid" do
#     assert @user.valid?
#   end
# end



# リスト 6.4:デフォルトのUserテスト (モックのみ)
# test/models/user_test.rb

# require 'test_helper'

# class UserTest < ActiveSupport::TestCase
#   # test "the truth" do
#   #   assert true
#   # end
# end




# require 'test_helper'

# class UserTest < ActiveSupport::TestCase
#   # test "the truth" do
#   #   assert true
#   # end
# end
