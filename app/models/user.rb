# app/models/user.rb

class User < ApplicationRecord
  attr_accessor :remember_token    # 9.3:rememberメソッドをUserモデルに追加
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64   #9.2 トークン生成用メソッドを追加
  end

  # 9.3:rememberメソッドをUserモデルに追加
  def remember   # 永続セッションのためにユーザーをデータベースに記憶
    self.remember_token = User.new_token   # 9.3
    update_attribute(:remember_digest, User.digest(remember_token))   # 9.3:
  end

  # 9.6:authenticated?をUserモデルに追加
  def authenticated?(remember_token)
    return false if remember_digest.nil?   # 渡されたトークンがダイジェストと一致したらtrueを返す
    BCrypt::Password.new(remember_digest).is_password?(remember_token)  # 9.6:authenticated?をUserモデルに追加
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)   #  9.11:forgetメソッドをUserモデルに追加
  end

end



# リスト 9.6:authenticated?をUserモデルに追加する
# # app/models/user.rb

# class User < ApplicationRecord
#   attr_accessor :remember_token    # 9.3:rememberメソッドをUserモデルに追加
#   before_save { self.email = email.downcase }
#   validates :name,  presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
#   has_secure_password
#   validates :password, presence: true, length: { minimum: 6 }

#   # 渡された文字列のハッシュ値を返す
#   def User.digest(string)
#     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
#                                                   BCrypt::Engine.cost
#     BCrypt::Password.create(string, cost: cost)
#   end

#   # ランダムなトークンを返す
#   def User.new_token
#     SecureRandom.urlsafe_base64
#   end

#   # 9.3:rememberメソッドをUserモデルに追加
#   def remember   # 永続セッションのためにユーザーをデータベースに記憶
#     self.remember_token = User.new_token
#     update_attribute(:remember_digest, User.digest(remember_token))
#   end

#   # 9.6:authenticated?をUserモデルに追加
#   # 渡されたトークンがダイジェストと一致したらtrueを返す
#   def authenticated?(remember_token)
#     BCrypt::Password.new(remember_digest).is_password?(remember_token)
#   end
# end




# # # リスト 9.3:rememberメソッドをUserモデルに追加する green
# # # app/models/user.rb

# class User < ApplicationRecord
#   attr_accessor :remember_token    #  9.3:rememberメソッドをUserモデルに追加
#   before_save { self.email = email.downcase }
#   validates :name,  presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
#   has_secure_password
#   validates :password, presence: true, length: { minimum: 6 }

#   # 渡された文字列のハッシュ値を返す
#   def User.digest(string)
#     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
#                                                   BCrypt::Engine.cost
#     BCrypt::Password.create(string, cost: cost)
#   end

#   # ランダムなトークンを返す
#   def User.new_token
#     SecureRandom.urlsafe_base64
#   end

#   # 9.3:rememberメソッドをUserモデルに追加
#   # 永続セッションのためにユーザーをデータベースに記憶
#   def remember
#     self.remember_token = User.new_token
#     update_attribute(:remember_digest, User.digest(remember_token))
#   end
# end



# # リスト 9.2:トークン生成用メソッドを追加する
# # app/models/user.rb

# class User < ApplicationRecord
#   before_save { self.email = email.downcase }
#   validates :name,  presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
#   has_secure_password
#   validates :password, presence: true, length: { minimum: 6 }

#   # 渡された文字列のハッシュ値を返す
#   def User.digest(string)    # リスト 8.21:fixture向けのdigestメソッドを追加する
#     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :    # リスト 8.21:fixture向けのdigestメソッドを追加する
#                                                   BCrypt::Engine.cost    # リスト 8.21:fixture向けのdigestメソッドを追加する
#     BCrypt::Password.create(string, cost: cost)    # リスト 8.21:fixture向けのdigestメソッドを追加する
#   end

  
#   # ランダムなトークンを返す # リスト 9.2:トークン生成用メソッドを追加する
#   def User.new_token
#     SecureRandom.urlsafe_base64
#   end
  
# end





# リスト 8.21:fixture向けのdigestメソッドを追加する
# app/models/user.rb

# class User < ApplicationRecord
#   before_save { self.email = email.downcase }
#   validates :name,  presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
#   has_secure_password
#   validates :password, presence: true, length: { minimum: 6 }

#   # 渡された文字列のハッシュ値を返す
#   def User.digest(string)
#     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
#                                                   BCrypt::Engine.cost
#     BCrypt::Password.create(string, cost: cost)
#   end
  
# end







# リスト 6.42:セキュアパスワードの完全な実装 green
# app/models/user.rb

# class User < ApplicationRecord
#   before_save { self.email = email.downcase }
#   validates :name, presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
#   has_secure_password
#   validates :password, presence: true, length: { minimum: 6 }
# end



# # リスト 6.37:Userモデルにhas_secure_passwordを追加する red
# # app/models/user.rb

# class User < ApplicationRecord
#   before_save { self.email = email.downcase }
#   validates :name, presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
#   has_secure_password
# end




# リスト 6.32:email属性を小文字に変換してメールアドレスの一意性を保証する green
# app/models/user.rb

# class User < ApplicationRecord
#   before_save { self.email = email.downcase }
#   validates :name,  presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
# end


# # リスト 6.27:メールアドレスの大文字小文字を無視した一意性の検証 green
# # app/models/user.rb

# class User < ApplicationRecord
#   validates :name,  presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
# end


# リスト 6.25:メールアドレスの一意性を検証する green
# app/models/user.rb

# class User < ApplicationRecord
#   validates :name,  presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: true
# end



# # リスト 6.21:メールフォーマットを正規表現で検証する green
# # app/models/user.rb

# class User < ApplicationRecord
#   validates :name,  presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX }
# end



# リスト 6.16:name属性に長さの検証を追加する green
# app/models/user.rb

# class User < ApplicationRecord
#   validates :name,  presence: true, length: { maximum: 50 }
#   validates :email, presence: true, length: { maximum: 255 }
# end



# リスト 6.12:email属性の存在性を検証する green
# app/models/user.rb

# class User < ApplicationRecord
#   validates :name,  presence: true
#   validates :email, presence: true
# end



# # リスト 6.9:name属性の存在性を検証する green
# # app/models/user.rb

# class User < ApplicationRecord
#   validates :name, presence: true
# end