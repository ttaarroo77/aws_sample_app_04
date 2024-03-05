# リスト 10.38:gravatar_forヘルパーにオプション引数を追加する
# app/helpers/users_helper.rb

module UsersHelper

  # 渡されたユーザーのGravatar画像を返す
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end



# # リスト 7.9:gravatar_forヘルパーメソッドを定義する
# # app/helpers/users_helper.rb

# module UsersHelper

#   # 引数で与えられたユーザーのGravatar画像を返す
#   def gravatar_for(user)
#     gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
#     gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
#     image_tag(gravatar_url, alt: user.name, class: "gravatar")  #ハッシュ化された値から、元のデータにはアクセスできない
#   end
# end