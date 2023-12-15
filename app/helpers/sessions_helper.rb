# リスト 8.29:log_outメソッド
# app/helpers/sessions_helper.rb


module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id    ##リスト 8.14:log_inメソッド
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id]    #リスト 8.16:セッションに含まれる現在のユーザーを検索する
      @current_user ||= User.find_by(id: session[:user_id])      #リスト 8.16:セッションに含まれる現在のユーザーを検索する
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?  # リスト 8.18:logged_in?ヘルパーメソッド
    !current_user.nil?
  end


  # 現在のユーザーをログアウトする
  def log_out    # # リスト 8.29:log_outメソッド
    session.delete(:user_id)
    @current_user = nil
  end

end


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
