class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end



# リスト 10.32:フレンドリーフォワーディングを備えたcreateアクション green
# app/controllers/sessions_controller.rb


# class SessionsController < ApplicationController

#   def new
#   end

#   def create
#     user = User.find_by(email: params[:session][:email].downcase)
#     # byebug
#     if user && user.authenticate(params[:session][:password])
#       # byebug
#       log_in user
#       params[:session][:remember_me] == '1' ? remember(user) : forget(user)  
#       redirect_back_or user   # 10.32:
#     else
#       flash.now[:danger] = 'Invalid email/password combination'
#       render 'new'
#     end
#   end

#   def destroy
#     log_out if logged_in? 
#     redirect_to root_url
#   end
# end




# リスト 9.23:[remember me] チェックボックスの送信結果を処理する
# app/controllers/sessions_controller.rb

# リスト 9.16:ログイン中の場合のみログアウトする green
# リスト 9.7:ログインしてユーザーを保持する


# class SessionsController < ApplicationController

#   def new
#   end

#   def create
#     user = User.find_by(email: params[:session][:email].downcase)
#     if user && user.authenticate(params[:session][:password])
#       log_in user
#       params[:session][:remember_me] == '1' ? remember(user) : forget(user)  # 9.23:[remember me] チェックボックスの送信結果を処理
#       redirect_to user
#     else
#       flash.now[:danger] = 'Invalid email/password combination'
#       render 'new'
#     end
#   end

#   def destroy
#     log_out if logged_in?   #  9.16:ログイン中の場合のみログアウトする green
#     redirect_to root_url
#   end
# end




# リスト 8.30:セッションを破棄する (ユーザーのログアウト)
# app/controllers/sessions_controller.rb

# class SessionsController < ApplicationController

#   def new
#   end

#   def create
#     user = User.find_by(email: params[:session][:email].downcase)    #リスト 8.7:
#     if user && user.authenticate(params[:session][:password])     #リスト 8.7:
#       log_in user
#       redirect_to user
#       # ユーザーログイン後にユーザー情報のページにリダイレクトする
#     else
#       flash.now[:danger] = 'Invalid email/password combination'      # リスト 8.11:ログイン失敗時の正しい処理 green
#       # flash[:danger] = 'Invalid email/password combination' #リスト 8.8:   # 本当は正しくない
#       render 'new'    # リスト 8.6:      
      
#     end
#   end

#   def destroy    # リスト 8.30:セッションを破棄する (ユーザーのログアウト)
#     log_out
#     redirect_to root_url
#   end
  
# end



# リスト 8.15:ユーザーにログインする
# app/controllers/sessions_controller.rb

# class SessionsController < ApplicationController

#   def new
#   end

#   def create
#     user = User.find_by(email: params[:session][:email].downcase)    #リスト 8.7:
#     if user && user.authenticate(params[:session][:password])     #リスト 8.7:
#       log_in user
#       redirect_to user
#       # ユーザーログイン後にユーザー情報のページにリダイレクトする
#     else
#       flash.now[:danger] = 'Invalid email/password combination'      # リスト 8.11:ログイン失敗時の正しい処理 green
#       # flash[:danger] = 'Invalid email/password combination' #リスト 8.8:   # 本当は正しくない
#       render 'new'    # リスト 8.6:      
      
#     end
#   end

#   def destroy
#   end
# end



# リスト 8.11:ログイン失敗時の正しい処理 green
# app/controllers/sessions_controller.rb

# class SessionsController < ApplicationController

#   def new
#   end

#   def create
#     user = User.find_by(email: params[:session][:email].downcase)    #リスト 8.7:
#     if user && user.authenticate(params[:session][:password])     #リスト 8.7:
#       # ユーザーログイン後にユーザー情報のページにリダイレクトする
#     else
#       flash.now[:danger] = 'Invalid email/password combination'      # リスト 8.11:ログイン失敗時の正しい処理 green
#       # flash[:danger] = 'Invalid email/password combination' #リスト 8.8:   # 本当は正しくない
#       render 'new'    # リスト 8.6:
#     end
#   end

#   def destroy
#   end
# end





# リスト 8.8:ログイン失敗時の処理を扱う (誤りあり)
# app/controllers/sessions_controller.rb

# class SessionsController < ApplicationController

#   def new
#   end

#   def create
#     user = User.find_by(email: params[:session][:email].downcase)    #リスト 8.7:
#     if user && user.authenticate(params[:session][:password])     #リスト 8.7:
#       # ユーザーログイン後にユーザー情報のページにリダイレクトする
#     else
#       flash[:danger] = 'Invalid email/password combination' #リスト 8.8:   # 本当は正しくない
#       render 'new'    # リスト 8.6:
#     end
#   end

#   def destroy
#   end
# end





# リスト 8.7:ユーザーをデータベースから見つけて検証する
# app/controllers/sessions_controller.rb

# class SessionsController < ApplicationController

#   def new
#   end

#   def create
#     user = User.find_by(email: params[:session][:email].downcase)
#     if user && user.authenticate(params[:session][:password])
#       # ユーザーログイン後にユーザー情報のページにリダイレクトする
#     else
#       # エラーメッセージを作成する
#       render 'new'
#     end
#   end

#   def destroy
#   end
# end



# # リスト 8.6:Sessionsコントローラのcreateアクション (暫定版)
# # app/controllers/sessions_controller.rb

# class SessionsController < ApplicationController

#   def new
#   end

#   def create
#     render 'new'
#   end

#   def destroy
#   end
# end



# class SessionsController < ApplicationController
#   def new
#   end
# end
