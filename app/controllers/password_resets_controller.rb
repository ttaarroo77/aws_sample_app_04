# リスト 12.16:パスワード再設定のupdateアクション
# app/controllers/password_resets_controller.rb

# リスト 12.15:パスワード再設定のeditアクション
# リスト 12.5:パスワード再設定用のcreateアクション


class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]    # 12.15
  before_action :valid_user,       only: [:edit, :update]    # 12.15
  before_action :check_expiration, only: [:edit, :update]    # (1) への対応  # 12.16

  def new
  end

  def create  # 12.5:
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end



  def update
    if params[:user][:password].empty?    # (3) への対応  # 12.16
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)  # (4) への対応  # 12.16
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'       # (2) への対応  # 12.16
    end
  end







  private    # 12.15

    def get_user      # 12.15
      @user = User.find_by(email: params[:email])
    end

    def valid_user      # 正しいユーザーかどうか確認する  # 12.15
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)  # 12.16
    end



    # beforeフィルタ

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 有効なユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end

end





# # リスト 12.5:パスワード再設定用のcreateアクション
# # app/controllers/password_resets_controller.rb

# class PasswordResetsController < ApplicationController

#   def new
#   end

#   def create
#     @user = User.find_by(email: params[:password_reset][:email].downcase)
#     if @user
#       @user.create_reset_digest
#       @user.send_password_reset_email
#       flash[:info] = "Email sent with password reset instructions"
#       redirect_to root_url
#     else
#       flash.now[:danger] = "Email address not found"
#       render 'new'
#     end
#   end

#   def edit
#   end
# end