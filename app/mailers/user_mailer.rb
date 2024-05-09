# リスト 12.7:パスワード再設定のリンクをメール送信する
# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"    # 12.7:
  end
end




# class UserMailer < ApplicationMailer

#   # Subject can be set in your I18n file at config/locales/en.yml
#   # with the following lookup:
#   #
#   #   en.user_mailer.account_activation.subject
#   #
#   def account_activation
#     @greeting = "Hi"

#     mail to: "to@example.org"
#   end

#   # Subject can be set in your I18n file at config/locales/en.yml
#   # with the following lookup:
#   #
#   #   en.user_mailer.password_reset.subject
#   #
#   def password_reset
#     @greeting = "Hi"

#     mail to: "to@example.org"
#   end
# end
