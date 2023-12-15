# リスト 8.21:fixture向けのdigestメソッドを追加する
# app/models/user.rb

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)    # リスト 8.21:fixture向けのdigestメソッドを追加する
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :    # リスト 8.21:fixture向けのdigestメソッドを追加する
                                                  BCrypt::Engine.cost    # リスト 8.21:fixture向けのdigestメソッドを追加する
    BCrypt::Password.create(string, cost: cost)    # リスト 8.21:fixture向けのdigestメソッドを追加する
  end
end





# リスト 6.42:セキュアパスワードの完全な実装 green
# app/models/user.rb

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end



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