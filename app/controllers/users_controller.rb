# app/controllers/users_controller.rb

# リスト 7.5:Usersコントローラのshowアクション
# リスト 7.6:debuggerをUsersコントローラに差し込む
# リスト 7.7:debuggerをUsersコントローラーから取り外す
# リスト 7.14:newアクションに@user変数を追加する
# リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# リスト 7.19:createアクションでStrong Parametersを使う
# リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# リスト 7.29:ユーザー登録ページにフラッシュメッセージを追加する

class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end









# app/controllers/users_controller.rb

# リスト 7.5:Usersコントローラのshowアクション
# リスト 7.6:debuggerをUsersコントローラに差し込む
# リスト 7.7:debuggerをUsersコントローラーから取り外す
# リスト 7.14:newアクションに@user変数を追加する
# リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# リスト 7.19:createアクションでStrong Parametersを使う
# リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# リスト 7.29:ユーザー登録ページにフラッシュメッセージを追加する

# class UsersController < ApplicationController

#   def show
#     @user = User.find(params[:id])
#   end

#   def new
#     @user = User.new
#   end

#   def create
#     # @user = User.new(params[:user])    # 実装は終わっていないことに注意!　　これと下は何が違う？？
#     @user = User.new(user_params)
#     if @user.save       # 保存の成功をここで扱う。
#       flash[:success] = "Welcome to the Sample App!"  #リスト 7.29:ユーザー登録ページにフラッシュメッセージを追加する
#       redirect_to @user　#リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
#       #redirect_to user_url(@user)   上と同じ
#     else
#       render 'new'
#     end
#   end

#   private

#     def user_params
#       params.require(:user).permit(:name, :email, :password,
#                                   :password_confirmation)
#     end
# end

















# リスト 7.28:保存とリダイレクトを行う、userのcreateアクション

# class UsersController < ApplicationController

#   def show
#     @user = User.find(params[:id])
#   end

#   def new
#     @user = User.new
#   end

#   def create
#     # @user = User.new(params[:user])    # 実装は終わっていないことに注意!　　これと下は何が違う？？
#     @user = User.new(user_params)
#     if @user.save       # 保存の成功をここで扱う。
#       redirect_to @user　#リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
#       #redirect_to user_url(@user)   上と同じ
#     else
#       render 'new'
#     end
#   end

#   private

#     def user_params
#       params.require(:user).permit(:name, :email, :password,
#                                   :password_confirmation)
#     end
# end



# # リスト 7.5:Usersコントローラのshowアクション
# # リスト 7.6:debuggerをUsersコントローラに差し込む
# # リスト 7.7:debuggerをUsersコントローラーから取り外す
# # リスト 7.14:newアクションに@user変数を追加する
# # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# # リスト 7.19:createアクションでStrong Parametersを使う
# # app/controllers/users_controller.rb

# class UsersController < ApplicationController

#   def show
#     @user = User.find(params[:id])
#   end

#   def new
#     @user = User.new
#   end

#   def create
#     # @user = User.new(params[:user])    # 実装は終わっていないことに注意!　　これと下は何が違う？？
#     @user = User.new(user_params)
#     if @user.save
#       # 保存の成功をここで扱う。
#     else
#       render 'new'
#     end
#   end

#   private

#     def user_params
#       params.require(:user).permit(:name, :email, :password,
#                                   :password_confirmation)
#     end
# end



# リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# app/controllers/users_controller.rb

# class UsersController < ApplicationController

#   def show
#     @user = User.find(params[:id])
#   end

#   def new
#     @user = User.new
#   end

#   def create
#     @user = User.new(params[:user])    # 実装は終わっていないことに注意!
#     if @user.save
#       # 保存の成功をここで扱う。
#     else
#       render 'new'
#     end
#   end
# end



# リスト 7.14:newアクションに@user変数を追加する
# app/controllers/users_controller.rb

# class UsersController < ApplicationController

#   def show
#     @user = User.find(params[:id])
#   end

#   def new
#     @user = User.new
#   end
# end



# リスト 7.5:Usersコントローラのshowアクション
# リスト 7.6:debuggerをUsersコントローラに差し込む
# リスト 7.7:debuggerをUsersコントローラーから取り外す
# app/controllers/users_controller.rb

# class UsersController < ApplicationController

#   def show    # リスト 7.5:Usersコントローラのshowアクション
#     @user = User.find(params[:id])
#     # debugger    # リスト 7.6:debuggerをUsersコントローラに差し込む　リスト 7.7:debuggerをUsersコントローラーから取り外す
#   end
  
#   def new    # new アクションの定義をしている
#   end
# end



# # リスト 5.39:newアクションを持つ最初のUsersコントローラ
# # app/controllers/users_controller.rb

# class UsersController < ApplicationController

#   def new
#     # new アクションの定義をしている
#   end
# end