# リスト 8.25:ユーザー登録中にログインする
# app/controllers/users_controller.rb

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
      log_in @user    #  リスト 8.25:ユーザー登録中にログインする
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






# # app/controllers/users_controller.rb

# # リスト 7.5:Usersコントローラのshowアクション
# # リスト 7.6:debuggerをUsersコントローラに差し込む
# # リスト 7.7:debuggerをUsersコントローラーから取り外す
# # リスト 7.14:newアクションに@user変数を追加する
# # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
# # リスト 7.19:createアクションでStrong Parametersを使う
# # リスト 7.28:保存とリダイレクトを行う、userのcreateアクション
# # リスト 7.29:ユーザー登録ページにフラッシュメッセージを追加する

# class UsersController < ApplicationController

#   def show
#     @user = User.find(params[:id])    #  インスタンス変数 @user なら、showアクションの外 (viewなど)　から呼び出し可能
#     # => app/views/users/show.html.erb から呼び出し可能
#     # debugger
#   end

#   def new    # ユーザー登録ページ /signup のルーティングは、Usersコントローラーのnewアクションに既に紐付けられている
#     @user = User.new #Userについて、newアクションする
#   end

#   def create    # createアクションでフォーム送信を受け取る
#     @user = User.new(user_params) #  privateの下で、user_params は定義してる。
#     # user = User.new(params[:user])    # 実装は終わっていないことに注意!    7.18
#     if @user.save  # userオブジェクトが返れば、surcess　// #バリデーション:データベースに保存する前に保存する内容を検証する機能
#       flash[:success] = "Welcome to the Sample App!"    #  flash：特殊な変数
#       redirect_to @user
#         # redirect_to "/users/#{@user.id}"  これのidは消して良い。
#         # redirect_to  user_path(@user.id)
#         # redirect_to  user_path(@user)
#         # =>  " /users/#{@user.id}"    このURLに飛ぶ
#         #  GET "/users/#{@user.id}" => show
#     else  #Failure
#       render 'new'  # newテンプレートを呼び出す。   render "new" = render action "new"
#     end
#   end

#   private

#     def user_params
#       params.require(:user).permit(:name, :email, :password, :password_confirmation)
#     end
# end



# GET /users/:id
# これ、どういう意味？


# def show
#   @user = User.find(params[:id])
#     => app./views/users/show.html.erb
# end

    # リスト 7.5:
    # ユーザーのid読み出しにはparamsを使いました。
    # Usersコントローラにリクエストが正常に送信されると、
    # params[:id]の部分はユーザーidの1に置き換わります。
    
    # つまり、この箇所は6.1.4で学んだfindメソッドの User.find(1)と同じになります。
    # (技術的な補足: params[:id]は文字列型の "1" ですが、
    # findメソッドでは自動的に整数型に変換されます)。

    # paramsとはRailsで送られてきた値を受け取るためのメソッドです。
    # 基本的には以下の形で用います。   #   params[:カラム名]
    # https://www.sejuku.net/blog/29763
    
    # 下の2つは同じ意味
      # @user = User.new(params[:user])
      # @user = User.new(name: "Foo Bar1", email: "foo1@invalid",　password: "foo1", password_confirmation: "bar1")
      #  オプション引数・・key に　シンボル、 value に値。　それらの集合体。
      # [:user:] の中に、 name:   email:  password:  pw_confirmation: が入ってる。



  # この２つのコードがリンクしている。
  # @user = User.new(user_params)

  # private    
  #   def user_params
  #     params.require(:user).permit(:name, :email, :password, :password_confirmation)
  #   end
  
  # このuser_paramsメソッドはUsersコントローラの内部でのみ実行され、
  # Web経由で外部ユーザーにさらされる必要はないため、
  # privateキーワードを使って外部から使えないようにします



# def create
  # @user = User.new  
    # @user.name = params[:user][:name] 
    # @user.email = params[:user][:email]
    # @user.password = params[:user][:password]
    # @user.save
  # render "new"   # newテンプレートを呼び出す
# end

# user = User.first  ローカル変数： showメソッド内でのみ「、user変数は値を保持。
# @user = User.first  インスタンス変数: showメソッド外、例えばviewアクションからも、user変数はアクセスできる。
# $user = User.first  グローバル変数：そのプロジェクト内、どこでも使える。(一般的には使わない)
# => app/views/users/show.html.erb











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