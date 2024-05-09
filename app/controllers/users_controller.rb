# リスト 13.33:Usersコントローラ内のlogged_in_userフィルターを削除する red
# リスト 13.23:@micropostsインスタンス変数をshowアクションに追加する
# app/controllers/users_controller.rb


class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])     # 13.23
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


    # beforeフィルター
    # def logged_in_user  #【削除】ログイン済みユーザーか確認  # 13.33
    #   unless logged_in? #【参考】13.34:Micropostsコントローラの各アクションに認可追加
    #     store_location
    #     flash[:danger] = "Please log in."
    #     redirect_to login_url
    #   end
    # end

    def correct_user    # 正しいユーザーかどうか確認
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    def admin_user      # 管理者かどうか確認
      redirect_to(root_url) unless current_user.admin?
    end
    
end

# 2024-05-08 chqp12?

# class UsersController < ApplicationController
#   before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
#   before_action :correct_user,   only: [:edit, :update]
#   before_action :admin_user,     only: :destroy

#   def index # 10.35
#     @users = User.paginate(page: params[:page]) # 10.46: # 10.36:
#   end

#   def show
#     @user = User.find(params[:id])
#   end

#   def new
#     @user = User.new
#   end

#   def create
#     @user = User.new(user_params)
#     if @user.save
#       @user.send_activation_email
#       flash[:info] = "Please check your email to activate your account."
#       redirect_to root_url
#     else
#       render 'new'
#     end
#   end

#   def edit
#     @user = User.find(params[:id])
#   end

#   def update
#     @user = User.find(params[:id])
#     if @user.update(user_params)
#       flash[:success] = "Profile updated"
#       redirect_to @user
#     else
#       render 'edit'
#     end
#   end

#   def destroy
#     User.find(params[:id]).destroy
#     flash[:success] = "User deleted"
#     redirect_to users_url
#   end

#   private

#     def user_params
#       params.require(:user).permit(:name, :email, :password,
#                                   :password_confirmation)
#     end

#     # beforeアクション

#     # ログイン済みユーザーかどうか確認
#     def logged_in_user
#       unless logged_in?
#         store_location
#         flash[:danger] = "Please log in."
#         redirect_to login_url
#       end
#     end

#     # 正しいユーザーかどうか確認
#     def correct_user
#       @user = User.find(params[:id])
#       redirect_to(root_url) unless current_user?(@user)
#     end

#     # 管理者かどうか確認
#     def admin_user
#       redirect_to(root_url) unless current_user.admin?
#     end
# end



# # # リスト 10.59:beforeフィルターでdestroyアクションを管理者だけに限定する

# # リスト 10.58:実際に動作するdestroyアクションを追加する
# # リスト 10.46:indexアクションでUsersをページネートする
# # リスト 10.36:ユーザーのindexアクション
# # リスト 10.35:indexアクションにはログインを要求する green
# # リスト 10.31:ログインユーザー用beforeフィルターにstore_locationを追加する red
# # リスト 10.28:最終的なcorrect_userの実装 green
# # リスト 10.25:beforeフィルターを使って編集/更新ページを保護する green
# # リスト 10.21:beforeフィルターを再び有効化する green
# # リスト 10.19:セキュリティモデルを確認するためにbeforeフィルターをコメントアウトする green
# # リスト 10.15:beforeフィルターにlogged_in_userを追加する red
# # リスト 10.12:ユーザーのupdateアクション red
# # リスト 10.8:ユーザーのupdateアクションの初期実装
# # リスト 10.1:ユーザーのeditアクション

# # app/controllers/users_controller.rb


# class UsersController < ApplicationController
#   before_action :logged_in_user, only: [:index, :edit, :update, :destroy]  # 10.58: 
#   before_action :correct_user,   only: [:edit, :update]
#   before_action :admin_user,     only: :destroy



#   def index # 10.35
#     @users = User.paginate(page: params[:page]) # 10.46: # 10.36:
#   end

#   def show
#     @user = User.find(params[:id])
#   end

#   def new
#     @user = User.new
#   end

#   def create
#     @user = User.new(user_params)
#     if @user.save   #  10.8:
#       log_in @user
#       flash[:success] = "Welcome to the Sample App!"
#       redirect_to @user
#     else
#       render 'new'  #  10.8:
#     end
#   end

#   def edit
#     @user = User.find(params[:id])   # 10.1:
#   end

#   def update
#     @user = User.find(params[:id])
#     if @user.update_attributes(user_params)  #  10.8:
#       flash[:success] = "Profile updated" # 10.12:
#       redirect_to @user # 10.12:
#     else
#       render 'edit'  #  10.8:
#     end
#   end

#   def destroy    # 10.58:
#     User.find(params[:id]).destroy
#     flash[:success] = "User deleted"
#     redirect_to users_url
#   end

#   private

#     def user_params
#       params.require(:user).permit(:name, :email, :password,
#                                   :password_confirmation)
#     end

#     # beforeアクション

#     # ログイン済みユーザーかどうか確認    # 10.15:
#     def logged_in_user
#       unless logged_in?
#         store_location  # 10.31
#         flash[:danger] = "Please log in."
#         redirect_to login_url
#       end
#     end

#     # 正しいユーザーかどうか確認 
#     def correct_user
#       @user = User.find(params[:id])
#       redirect_to(root_url) unless current_user?(@user)  # 10.28  # 10.25:
#     end

#     # 管理者かどうか確認   # 10.59:
#     def admin_user
#       redirect_to(root_url) unless current_user.admin?
#     end
    
# end



# # リスト 8.25:ユーザー登録中にログインする
# # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     @user = User.new(user_params)
# #     if @user.save
# #       log_in @user    #  リスト 8.25:ユーザー登録中にログインする
# #       flash[:success] = "Welcome to the Sample App!"
# #       redirect_to @user
# #     else
# #       render 'new'
# #     end
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password,
# #                                   :password_confirmation)
# #     end
# # end






# # # app/controllers/users_controller.rb

# # # リスト 7.5:Usersコントローラのshowアクション
# # # リスト 7.6:debuggerをUsersコントローラに差し込む
# # # リスト 7.7:debuggerをUsersコントローラーから取り外す
# # # リスト 7.14:newアクションに@user変数を追加する
# # # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# # # リスト 7.19:createアクションでStrong Parametersを使う
# # # リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# # # リスト 7.29:ユーザー登録ページにフラッシュメッセージを追加する

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])    #  インスタンス変数 @user なら、showアクションの外 (viewなど)　から呼び出し可能
# #     # => app/views/users/show.html.erb から呼び出し可能
# #     # debugger
# #   end

# #   def new    # ユーザー登録ページ /signup のルーティングは、Usersコントローラーのnewアクションに既に紐付けられている
# #     @user = User.new #Userについて、newアクションする
# #   end

# #   def create    # createアクションでフォーム送信を受け取る
# #     @user = User.new(user_params) #  privateの下で、user_params は定義してる。
# #     # user = User.new(params[:user])    # 実装は終わっていないことに注意!    7.18
# #     if @user.save  # userオブジェクトが返れば、surcess　// #バリデーション:データベースに保存する前に保存する内容を検証する機能
# #       flash[:success] = "Welcome to the Sample App!"    #  flash：特殊な変数
# #       redirect_to @user
# #         # redirect_to "/users/#{@user.id}"  これのidは消して良い。
# #         # redirect_to  user_path(@user.id)
# #         # redirect_to  user_path(@user)
# #         # =>  " /users/#{@user.id}"    このURLに飛ぶ
# #         #  GET "/users/#{@user.id}" => show
# #     else  #Failure
# #       render 'new'  # newテンプレートを呼び出す。   render "new" = render action "new"
# #     end
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password, :password_confirmation)
# #     end
# # end



# # GET /users/:id
# # これ、どういう意味？


# # def show
# #   @user = User.find(params[:id])
# #     => app./views/users/show.html.erb
# # end

#     # リスト 7.5:
#     # ユーザーのid読み出しにはparamsを使いました。
#     # Usersコントローラにリクエストが正常に送信されると、
#     # params[:id]の部分はユーザーidの1に置き換わります。
    
#     # つまり、この箇所は6.1.4で学んだfindメソッドの User.find(1)と同じになります。
#     # (技術的な補足: params[:id]は文字列型の "1" ですが、
#     # findメソッドでは自動的に整数型に変換されます)。

#     # paramsとはRailsで送られてきた値を受け取るためのメソッドです。
#     # 基本的には以下の形で用います。   #   params[:カラム名]
#     # https://www.sejuku.net/blog/29763
    
#     # 下の2つは同じ意味
#       # @user = User.new(params[:user])
#       # @user = User.new(name: "Foo Bar1", email: "foo1@invalid",　password: "foo1", password_confirmation: "bar1")
#       #  オプション引数・・key に　シンボル、 value に値。　それらの集合体。
#       # [:user:] の中に、 name:   email:  password:  pw_confirmation: が入ってる。



#   # この２つのコードがリンクしている。
#   # @user = User.new(user_params)

#   # private    
#   #   def user_params
#   #     params.require(:user).permit(:name, :email, :password, :password_confirmation)
#   #   end
  
#   # このuser_paramsメソッドはUsersコントローラの内部でのみ実行され、
#   # Web経由で外部ユーザーにさらされる必要はないため、
#   # privateキーワードを使って外部から使えないようにします



# # def create
#   # @user = User.new  
#     # @user.name = params[:user][:name] 
#     # @user.email = params[:user][:email]
#     # @user.password = params[:user][:password]
#     # @user.save
#   # render "new"   # newテンプレートを呼び出す
# # end

# # user = User.first  ローカル変数： showメソッド内でのみ「、user変数は値を保持。
# # @user = User.first  インスタンス変数: showメソッド外、例えばviewアクションからも、user変数はアクセスできる。
# # $user = User.first  グローバル変数：そのプロジェクト内、どこでも使える。(一般的には使わない)
# # => app/views/users/show.html.erb











# # app/controllers/users_controller.rb

# # リスト 7.5:Usersコントローラのshowアクション
# # リスト 7.6:debuggerをUsersコントローラに差し込む
# # リスト 7.7:debuggerをUsersコントローラーから取り外す
# # リスト 7.14:newアクションに@user変数を追加する
# # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# # リスト 7.19:createアクションでStrong Parametersを使う
# # リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# # リスト 7.29:ユーザー登録ページにフラッシュメッセージを追加する

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     # @user = User.new(params[:user])    # 実装は終わっていないことに注意!　　これと下は何が違う？？
# #     @user = User.new(user_params)
# #     if @user.save       # 保存の成功をここで扱う。
# #       flash[:success] = "Welcome to the Sample App!"  #リスト 7.29:ユーザー登録ページにフラッシュメッセージを追加する
# #       redirect_to @user　#リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# #       #redirect_to user_url(@user)   上と同じ
# #     else
# #       render 'new'
# #     end
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password,
# #                                   :password_confirmation)
# #     end
# # end

















# # リスト 7.28:保存とリダイレクトを行う、userのcreateアクション

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     # @user = User.new(params[:user])    # 実装は終わっていないことに注意!　　これと下は何が違う？？
# #     @user = User.new(user_params)
# #     if @user.save       # 保存の成功をここで扱う。
# #       redirect_to @user　#リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# #       #redirect_to user_url(@user)   上と同じ
# #     else
# #       render 'new'
# #     end
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password,
# #                                   :password_confirmation)
# #     end
# # end



# # # リスト 7.5:Usersコントローラのshowアクション
# # # リスト 7.6:debuggerをUsersコントローラに差し込む
# # # リスト 7.7:debuggerをUsersコントローラーから取り外す
# # # リスト 7.14:newアクションに@user変数を追加する
# # # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# # # リスト 7.19:createアクションでStrong Parametersを使う
# # # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     # @user = User.new(params[:user])    # 実装は終わっていないことに注意!　　これと下は何が違う？？
# #     @user = User.new(user_params)
# #     if @user.save
# #       # 保存の成功をここで扱う。
# #     else
# #       render 'new'
# #     end
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password,
# #                                   :password_confirmation)
# #     end
# # end



# # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     @user = User.new(params[:user])    # 実装は終わっていないことに注意!
# #     if @user.save
# #       # 保存の成功をここで扱う。
# #     else
# #       render 'new'
# #     end
# #   end
# # end



# # リスト 7.14:newアクションに@user変数を追加する
# # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end
# # end



# # リスト 7.5:Usersコントローラのshowアクション
# # リスト 7.6:debuggerをUsersコントローラに差し込む
# # リスト 7.7:debuggerをUsersコントローラーから取り外す
# # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def show    # リスト 7.5:Usersコントローラのshowアクション
# #     @user = User.find(params[:id])
# #     # debugger    # リスト 7.6:debuggerをUsersコントローラに差し込む　リスト 7.7:debuggerをUsersコントローラーから取り外す
# #   end
  
# #   def new    # new アクションの定義をしている
# #   end
# # end



# # # リスト 5.39:newアクションを持つ最初のUsersコントローラ
# # # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def new
# #     # new アクションの定義をしている
# #   end
# # end


# #   def index # 10.35
# #     @users = User.paginate(page: params[:page]) # 10.46: # 10.36:
# #   end

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     @user = User.new(user_params)
# #     if @user.save   #  10.8:
# #       log_in @user
# #       flash[:success] = "Welcome to the Sample App!"
# #       redirect_to @user
# #     else
# #       render 'new'  #  10.8:
# #     end
# #   end

# #   def edit
# #     @user = User.find(params[:id])   # 10.1:
# #   end

# #   def update
# #     @user = User.find(params[:id])
# #     if @user.update_attributes(user_params)  #  10.8:
# #       flash[:success] = "Profile updated" # 10.12:
# #       redirect_to @user # 10.12:
# #     else
# #       render 'edit'  #  10.8:
# #     end
# #   end

# #   def destroy    # 10.58:
# #     User.find(params[:id]).destroy
# #     flash[:success] = "User deleted"
# #     redirect_to users_url
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password,
# #                                   :password_confirmation)
# #     end

# #     # beforeアクション

# #     # ログイン済みユーザーかどうか確認    # 10.15:
# #     def logged_in_user
# #       unless logged_in?
# #         store_location  # 10.31
# #         flash[:danger] = "Please log in."
# #         redirect_to login_url
# #       end
# #     end

# #     # 正しいユーザーかどうか確認 
# #     def correct_user
# #       @user = User.find(params[:id])
# #       redirect_to(root_url) unless current_user?(@user)  # 10.28  # 10.25:
# #     end

# #     # 管理者かどうか確認   # 10.59:
# #     def admin_user
# #       redirect_to(root_url) unless current_user.admin?
# #     end
    
# # end



# # リスト 8.25:ユーザー登録中にログインする
# # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     @user = User.new(user_params)
# #     if @user.save
# #       log_in @user    #  リスト 8.25:ユーザー登録中にログインする
# #       flash[:success] = "Welcome to the Sample App!"
# #       redirect_to @user
# #     else
# #       render 'new'
# #     end
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password,
# #                                   :password_confirmation)
# #     end
# # end






# # # app/controllers/users_controller.rb

# # # リスト 7.5:Usersコントローラのshowアクション
# # # リスト 7.6:debuggerをUsersコントローラに差し込む
# # # リスト 7.7:debuggerをUsersコントローラーから取り外す
# # # リスト 7.14:newアクションに@user変数を追加する
# # # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# # # リスト 7.19:createアクションでStrong Parametersを使う
# # # リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# # # リスト 7.29:ユーザー登録ページにフラッシュメッセージを追加する

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])    #  インスタンス変数 @user なら、showアクションの外 (viewなど)　から呼び出し可能
# #     # => app/views/users/show.html.erb から呼び出し可能
# #     # debugger
# #   end

# #   def new    # ユーザー登録ページ /signup のルーティングは、Usersコントローラーのnewアクションに既に紐付けられている
# #     @user = User.new #Userについて、newアクションする
# #   end

# #   def create    # createアクションでフォーム送信を受け取る
# #     @user = User.new(user_params) #  privateの下で、user_params は定義してる。
# #     # user = User.new(params[:user])    # 実装は終わっていないことに注意!    7.18
# #     if @user.save  # userオブジェクトが返れば、surcess　// #バリデーション:データベースに保存する前に保存する内容を検証する機能
# #       flash[:success] = "Welcome to the Sample App!"    #  flash：特殊な変数
# #       redirect_to @user
# #         # redirect_to "/users/#{@user.id}"  これのidは消して良い。
# #         # redirect_to  user_path(@user.id)
# #         # redirect_to  user_path(@user)
# #         # =>  " /users/#{@user.id}"    このURLに飛ぶ
# #         #  GET "/users/#{@user.id}" => show
# #     else  #Failure
# #       render 'new'  # newテンプレートを呼び出す。   render "new" = render action "new"
# #     end
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password, :password_confirmation)
# #     end
# # end



# # GET /users/:id
# # これ、どういう意味？


# # def show
# #   @user = User.find(params[:id])
# #     => app./views/users/show.html.erb
# # end

#     # リスト 7.5:
#     # ユーザーのid読み出しにはparamsを使いました。
#     # Usersコントローラにリクエストが正常に送信されると、
#     # params[:id]の部分はユーザーidの1に置き換わります。
    
#     # つまり、この箇所は6.1.4で学んだfindメソッドの User.find(1)と同じになります。
#     # (技術的な補足: params[:id]は文字列型の "1" ですが、
#     # findメソッドでは自動的に整数型に変換されます)。

#     # paramsとはRailsで送られてきた値を受け取るためのメソッドです。
#     # 基本的には以下の形で用います。   #   params[:カラム名]
#     # https://www.sejuku.net/blog/29763
    
#     # 下の2つは同じ意味
#       # @user = User.new(params[:user])
#       # @user = User.new(name: "Foo Bar1", email: "foo1@invalid",　password: "foo1", password_confirmation: "bar1")
#       #  オプション引数・・key に　シンボル、 value に値。　それらの集合体。
#       # [:user:] の中に、 name:   email:  password:  pw_confirmation: が入ってる。



#   # この２つのコードがリンクしている。
#   # @user = User.new(user_params)

#   # private    
#   #   def user_params
#   #     params.require(:user).permit(:name, :email, :password, :password_confirmation)
#   #   end
  
#   # このuser_paramsメソッドはUsersコントローラの内部でのみ実行され、
#   # Web経由で外部ユーザーにさらされる必要はないため、
#   # privateキーワードを使って外部から使えないようにします



# # def create
#   # @user = User.new  
#     # @user.name = params[:user][:name] 
#     # @user.email = params[:user][:email]
#     # @user.password = params[:user][:password]
#     # @user.save
#   # render "new"   # newテンプレートを呼び出す
# # end

# # user = User.first  ローカル変数： showメソッド内でのみ「、user変数は値を保持。
# # @user = User.first  インスタンス変数: showメソッド外、例えばviewアクションからも、user変数はアクセスできる。
# # $user = User.first  グローバル変数：そのプロジェクト内、どこでも使える。(一般的には使わない)
# # => app/views/users/show.html.erb











# # app/controllers/users_controller.rb

# # リスト 7.5:Usersコントローラのshowアクション
# # リスト 7.6:debuggerをUsersコントローラに差し込む
# # リスト 7.7:debuggerをUsersコントローラーから取り外す
# # リスト 7.14:newアクションに@user変数を追加する
# # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# # リスト 7.19:createアクションでStrong Parametersを使う
# # リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# # リスト 7.29:ユーザー登録ページにフラッシュメッセージを追加する

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     # @user = User.new(params[:user])    # 実装は終わっていないことに注意!　　これと下は何が違う？？
# #     @user = User.new(user_params)
# #     if @user.save       # 保存の成功をここで扱う。
# #       flash[:success] = "Welcome to the Sample App!"  #リスト 7.29:ユーザー登録ページにフラッシュメッセージを追加する
# #       redirect_to @user　#リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# #       #redirect_to user_url(@user)   上と同じ
# #     else
# #       render 'new'
# #     end
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password,
# #                                   :password_confirmation)
# #     end
# # end

















# # リスト 7.28:保存とリダイレクトを行う、userのcreateアクション

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     # @user = User.new(params[:user])    # 実装は終わっていないことに注意!　　これと下は何が違う？？
# #     @user = User.new(user_params)
# #     if @user.save       # 保存の成功をここで扱う。
# #       redirect_to @user　#リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# #       #redirect_to user_url(@user)   上と同じ
# #     else
# #       render 'new'
# #     end
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password,
# #                                   :password_confirmation)
# #     end
# # end



# # # リスト 7.5:Usersコントローラのshowアクション
# # # リスト 7.6:debuggerをUsersコントローラに差し込む
# # # リスト 7.7:debuggerをUsersコントローラーから取り外す
# # # リスト 7.14:newアクションに@user変数を追加する
# # # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# # # リスト 7.19:createアクションでStrong Parametersを使う
# # # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     # @user = User.new(params[:user])    # 実装は終わっていないことに注意!　　これと下は何が違う？？
# #     @user = User.new(user_params)
# #     if @user.save
# #       # 保存の成功をここで扱う。
# #     else
# #       render 'new'
# #     end
# #   end

# #   private

# #     def user_params
# #       params.require(:user).permit(:name, :email, :password,
# #                                   :password_confirmation)
# #     end
# # end



# # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end

# #   def create
# #     @user = User.new(params[:user])    # 実装は終わっていないことに注意!
# #     if @user.save
# #       # 保存の成功をここで扱う。
# #     else
# #       render 'new'
# #     end
# #   end
# # end



# # リスト 7.14:newアクションに@user変数を追加する
# # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def show
# #     @user = User.find(params[:id])
# #   end

# #   def new
# #     @user = User.new
# #   end
# # end



# # リスト 7.5:Usersコントローラのshowアクション
# # リスト 7.6:debuggerをUsersコントローラに差し込む
# # リスト 7.7:debuggerをUsersコントローラーから取り外す
# # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def show    # リスト 7.5:Usersコントローラのshowアクション
# #     @user = User.find(params[:id])
# #     # debugger    # リスト 7.6:debuggerをUsersコントローラに差し込む　リスト 7.7:debuggerをUsersコントローラーから取り外す
# #   end
  
# #   def new    # new アクションの定義をしている
# #   end
# # end



# # # リスト 5.39:newアクションを持つ最初のUsersコントローラ
# # # app/controllers/users_controller.rb

# # class UsersController < ApplicationController

# #   def new
# #     # new アクションの定義をしている
# #   end
# # end