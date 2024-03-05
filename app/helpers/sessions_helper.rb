# リスト 10.30:フレンドリーフォワーディングの実装 red
# リスト 10.27:current_user?メソッド

# app/helpers/sessions_helper.rb



module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 渡されたユーザーがログイン済みユーザーであればtrueを返す  //  # 10.27:
  def current_user?(user)
    user == current_user   # 10.27:
  end

 # 記憶トークンcookieに対応するユーザーを返す  //  # 9.9:永続的セッションのcurrent_userを更新
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])   # 9.33:例外発生部分を削除
      # raise       #  9.29 // テストがパスすれば、この部分がテストされていないことがわかる    
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # 永続的セッションを破棄する   9.12:永続セッションからログアウトする green    
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end  
  
  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user) # 9.12:永続セッションからログアウトする green      
    session.delete(:user_id)
    @current_user = nil
  end
  
  
  # 記憶したURL (もしくはデフォルト値) にリダイレクト //  # 10.30:
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく // # 10.30:
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end




# リスト 9.33:例外発生部分を削除する green
# app/helpers/sessions_helper.rb

# リスト 9.29:テストされていないブランチで例外を発生する green
# リスト 9.12:永続セッションからログアウトする green 
# リスト 9.9:永続的セッションのcurrent_userを更新する red
# リスト 9.8:ユーザーを記憶する


# module SessionsHelper

#   # 渡されたユーザーでログインする
#   def log_in(user)
#     session[:user_id] = user.id
#   end

#   # ユーザーのセッションを永続的にする
#   def remember(user)
#     user.remember
#     cookies.permanent.signed[:user_id] = user.id
#     cookies.permanent[:remember_token] = user.remember_token
#   end

# # 記憶トークンcookieに対応するユーザーを返す  //  # 9.9:永続的セッションのcurrent_userを更新
#   def current_user
#     if (user_id = session[:user_id])
#       @current_user ||= User.find_by(id: user_id)
#     elsif (user_id = cookies.signed[:user_id])   # 9.33:例外発生部分を削除
#       # raise       #  9.29 // テストがパスすれば、この部分がテストされていないことがわかる    
#       user = User.find_by(id: user_id)
#       if user && user.authenticated?(cookies[:remember_token])
#         log_in user
#         @current_user = user
#       end
#     end
#   end

#   # ユーザーがログインしていればtrue、その他ならfalseを返す
#   def logged_in?
#     !current_user.nil?
#   end
  
#   # 永続的セッションを破棄する   9.12:永続セッションからログアウトする green    
#   def forget(user)
#     user.forget
#     cookies.delete(:user_id)
#     cookies.delete(:remember_token)
#   end  
  
#   # 現在のユーザーをログアウトする
#   def log_out
#     forget(current_user) # 9.12:永続セッションからログアウトする green      
#     session.delete(:user_id)
#     @current_user = nil
#   end
# end




# リスト 8.29:log_outメソッド
# app/helpers/sessions_helper.rb


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
