# リスト 9.33:例外発生部分を削除する green
# app/helpers/sessions_helper.rb

module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id    ##リスト 8.14:log_inメソッド
  end

  # ユーザーのセッションを永続的にする
  def remember(user)    # 9.8  ユーザーのセッションを永続的にする
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])   # 8.16:セッションに含まれる現在のユーザーを検索する
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])   # 9.33:例外発生部分を削除する 
      # raise       # 9.29 # テストがパスすれば、この部分がテストされていないことがわかる
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?  # リスト 8.18:logged_in?ヘルパーメソッド
    !current_user.nil?
  end
  
  # 永続的セッションを破棄する
  def forget(user)    # 9.12:永続セッションからログアウト #永続的セッションを破棄する
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out    # # リスト 8.29:log_outメソッド
    forget(current_user)    #  9.12:永続セッションからログアウト
    session.delete(:user_id)
    @current_user = nil
  end

end




# リスト 8.29:log_outメソッド
# app/helpers/sessions_helper.rb

# module SessionsHelper

#   # 渡されたユーザーでログインする
#   def log_in(user)
#     session[:user_id] = user.id    ##リスト 8.14:log_inメソッド
#   end

#   # 現在ログイン中のユーザーを返す (いる場合)
#   def current_user
#     if session[:user_id]  # 8.16:セッションに含まれる現在のユーザーを検索する
#       @current_user ||= User.find_by(id: session[:user_id]) # 8.16:セッションに含まれる現在のユーザーを検索
#     end
#   end

#   # ユーザーがログインしていればtrue、その他ならfalseを返す
#   def logged_in?  # リスト 8.18:logged_in?ヘルパーメソッド
#     !current_user.nil?
#   end

#   # 現在のユーザーをログアウトする
#   def log_out    # # リスト 8.29:log_outメソッド
#     session.delete(:user_id)
#     @current_user = nil
#   end

# end


# # リスト 8.18:logged_in?ヘルパーメソッド
# # app/helpers/sessions_helper.rb

# module SessionsHelper

#   # 渡されたユーザーでログインする
#   def log_in(user)
#     session[:user_id] = user.id    ##リスト 8.14:log_inメソッド
#   end

#   # 現在ログイン中のユーザーを返す (いる場合)
#   def current_user
#     if session[:user_id]    #リスト 8.16:セッションに含まれる現在のユーザーを検索する
#       @current_user ||= User.find_by(id: session[:user_id])      #リスト 8.16:セッションに含まれる現在のユーザーを検索する
#     end
#   end

#   # ユーザーがログインしていればtrue、その他ならfalseを返す
#   def logged_in?
#     !current_user.nil?    # リスト 8.18:logged_in?ヘルパーメソッド
#   end

# end





# # リスト 8.16:セッションに含まれる現在のユーザーを検索する
# # app/helpers/sessions_helper.rb

# module SessionsHelper

#   # 渡されたユーザーでログインする
#   def log_in(user)
#     session[:user_id] = user.id    ##リスト 8.14:log_inメソッド
#   end

#   # 現在ログイン中のユーザーを返す (いる場合)
#   def current_user
#     if session[:user_id]    #リスト 8.16:セッションに含まれる現在のユーザーを検索する
#       @current_user ||= User.find_by(id: session[:user_id])      #リスト 8.16:セッションに含まれる現在のユーザーを検索する
#     end
#   end
# end



# # リスト 8.14:log_inメソッド
# # app/helpers/sessions_helper.rb


# module SessionsHelper

#   # 渡されたユーザーでログインする
#   def log_in(user)
#     session[:user_id] = user.id
#   end
# end


# module SessionsHelper
# end
