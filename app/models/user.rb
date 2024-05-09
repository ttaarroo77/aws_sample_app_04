# リスト 13.46:マイクロポストのステータスフィードを実装するための準備
# リスト 13.19:マイクロポストは、その所有者 (ユーザー) と一緒に破棄されることを保証する
# リスト 13.11:ユーザーがマイクロポストを複数所有する (has_many) 関連付け green
# app/models/user.rb 


class User < ApplicationRecord
  # has_many :microposts 								 # 13.11
  has_many :microposts, dependent: :destroy   # 13.19
  attr_accessor :remember_token, :activation_token, :reset_token  # 12.6
  before_save   :downcase_email
  before_create :create_activation_digest  
  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def User.digest(string)# 渡された文字列のハッシュ値を返す
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token    # ランダムなトークンを返す 
    SecureRandom.urlsafe_base64
  end

  def remember   # 永続セッションのためにユーザーをデータベースに記憶する
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token) 
    # トークンがダイジェストと一致したらtrueを返す
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def forget    # ユーザーのログイン情報を破棄する
    update_attribute(:remember_digest, nil)
  end

  def activate    # アカウントを有効にする 
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email    # 有効化用のメールを送信する
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest  # パスワード再設定の属性を設定  # 12.6
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email  # パスワード再設定のメールを送信  # 12.6
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?   # パスワード再設定の期限が切れている場合 true  # 12.17:
    reset_sent_at < 2.hours.ago
  end

  # 試作feedの定義
  # 完全な実装は次章の「ユーザーをフォローする」を参照				 # 13.46
  def feed
    Micropost.where("user_id = ?", id)
  end

  private

    def downcase_email        # メールアドレスをすべて小文字にする
      self.email = email.downcase 
    end

    def create_activation_digest    # 有効化トークンとダイジェストを作成および代入
      self.activation_token  = User.new_token  # 11.3
      self.activation_digest = User.digest(activation_token)
    end

end



# リスト 12.17:Userモデルにパスワード再設定用メソッドを追加する
# リスト 12.6:Userモデルにパスワード再設定用メソッドを追加する　　# app/models/user.rb

# class User < ApplicationRecord
#   attr_accessor :remember_token, :activation_token, :reset_token  # 12.6
#   before_save   :downcase_email
#   before_create :create_activation_digest  
  
#   validates :name,  presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
#   has_secure_password
#   validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

#   def User.digest(string)# 渡された文字列のハッシュ値を返す
#     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
#                                                   BCrypt::Engine.cost
#     BCrypt::Password.create(string, cost: cost)
#   end

#   def User.new_token    # ランダムなトークンを返す 
#     SecureRandom.urlsafe_base64
#   end

#   def remember   # 永続セッションのためにユーザーをデータベースに記憶する
#     self.remember_token = User.new_token
#     update_attribute(:remember_digest, User.digest(remember_token))
#   end

#   def authenticated?(attribute, token) 
#     # トークンがダイジェストと一致したらtrueを返す
#     digest = send("#{attribute}_digest")
#     return false if digest.nil?
#     BCrypt::Password.new(digest).is_password?(token)
#   end
  
#   def forget    # ユーザーのログイン情報を破棄する
#     update_attribute(:remember_digest, nil)
#   end

#   def activate    # アカウントを有効にする 
#     update_attribute(:activated,    true)
#     update_attribute(:activated_at, Time.zone.now)
#   end

#   def send_activation_email    # 有効化用のメールを送信する
#     UserMailer.account_activation(self).deliver_now
#   end

#   def create_reset_digest  # パスワード再設定の属性を設定  # 12.6
#     self.reset_token = User.new_token
#     update_attribute(:reset_digest,  User.digest(reset_token))
#     update_attribute(:reset_sent_at, Time.zone.now)
#   end

#   def send_password_reset_email  # パスワード再設定のメールを送信  # 12.6
#     UserMailer.password_reset(self).deliver_now
#   end

#   def password_reset_expired?   # パスワード再設定の期限が切れている場合 true  # 12.17:
#     reset_sent_at < 2.hours.ago
#   end

#   private

#     def downcase_email        # メールアドレスをすべて小文字にする
#       self.email = email.downcase 
#     end

#     def create_activation_digest    # 有効化トークンとダイジェストを作成および代入
#       self.activation_token  = User.new_token  # 11.3
#       self.activation_digest = User.digest(activation_token)
#     end

# end






# # リスト 10.13:パスワードが空のままでも更新できるようにする green
# # app/models/user.rb


# class User < ApplicationRecord
#   attr_accessor :remember_token
#   before_save { self.email = email.downcase }
#   validates :name,  presence: true, length: { maximum: 50 }
#   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   validates :email, presence: true, length: { maximum: 255 },
#                     format: { with: VALID_EMAIL_REGEX },
#                     uniqueness: { case_sensitive: false }
#   has_secure_password
#   validates :password, presence: true, length: { minimum: 6 }, allow_nil: true  # 10.13:

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

#   # 永続セッションのためにユーザーをデータベースに記憶する
#   def remember
#     self.remember_token = User.new_token
#     update_attribute(:remember_digest, User.digest(remember_token))
#   end

#   # 渡されたトークンがダイジェストと一致したらtrueを返す 
#   def authenticated?(remember_token)
#     return false if remember_digest.nil?
#     BCrypt::Password.new(remember_digest).is_password?(remember_token) 
#   end
  
#   # ユーザーのログイン情報を破棄する
#   def forget
#     update_attribute(:remember_digest, nil)
#   end
  
# end




  # リスト 9.19:authenticated?を更新して、ダイジェストが存在しない場合に対応 green  
  # リスト 9.11:forgetメソッドをUserモデルに追加する red
  # リスト 9.6:authenticated?をUserモデルに追加する
  # リスト 9.3:rememberメソッドをUserモデルに追加する green
  # リスト 9.2:トークン生成用メソッドを追加

  # app/models/user.rb


# class User < ApplicationRecord
#   attr_accessor :remember_token    # 9.3:rememberメソッドをUserモデルに追加する green
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

#   # 9.2:トークン生成用メソッドを追加
#   # ランダムなトークンを返す
#   def User.new_token
#     SecureRandom.urlsafe_base64
#   end

#   # 9.3:rememberメソッドをUserモデルに追加する green
#   # 永続セッションのためにユーザーをデータベースに記憶する
#   def remember
#     self.remember_token = User.new_token
#     update_attribute(:remember_digest, User.digest(remember_token))
#   end

#   # リスト 9.19:authenticated?を更新して、ダイジェストが存在しない場合に対応 green  
#   # 渡されたトークンがダイジェストと一致したらtrueを返す
#   def authenticated?(remember_token)
#     return false if remember_digest.nil? # 9.19:authenticated?を更新して、ダイジェストが存在しない場合に対応 green    
#     BCrypt::Password.new(remember_digest).is_password?(remember_token)  # 9.6:authenticated?をUserモデルに追加
#   end
  
#   # リスト 9.11:forgetメソッドをUserモデルに追加する red
#   # ユーザーのログイン情報を破棄する
#   def forget
#     update_attribute(:remember_digest, nil)   # 9.11:forgetメソッドをUserモデルに追加する red
#   end
  
# end





#   # リスト 9.19:authenticated?を更新して、ダイジェストが存在しない場合に対応 green  
#   # リスト 9.11:forgetメソッドをUserモデルに追加する red

#   # app/models/user.rb

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
  
  
#   # リスト 9.19:authenticated?を更新して、ダイジェストが存在しない場合に対応 green  
#   # 渡されたトークンがダイジェストと一致したらtrueを返す
#   def authenticated?(remember_token)
#     return false if remember_digest.nil? # 9.19:authenticated?を更新して、ダイジェストが存在しない場合に対応 green    
#     BCrypt::Password.new(remember_digest).is_password?(remember_token)
#   end
  
#   # リスト 9.11:forgetメソッドをUserモデルに追加する red
#   # ユーザーのログイン情報を破棄する
#   def forget
#     update_attribute(:remember_digest, nil)   # 9.11:forgetメソッドをUserモデルに追加する red
#   end
  
# end



# # リスト 8.21:fixture向けのdigestメソッドを追加する
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