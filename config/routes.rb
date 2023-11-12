# リスト 3.41:HomeページをルートURLに設定する
# config/routes.rb

Rails.application.routes.draw do
  root 'static_pages#home'
  get  'static_pages/home'
  get  'static_pages/help'
  get  'static_pages/about'
end



# リスト 3.7:StaticPagesコントローラ内のhomeアクションとhelpアクションで使うルーティング
# config/routes.rb

# Rails.application.routes.draw do
#   get  'static_pages/home'
#   get  'static_pages/help'
#   get  'static_pages/about'
#   root 'application#hello'
# end


# # リスト 3.5:ルートルーティングを設定する
# # config/routes.rb

# Rails.application.routes.draw do
#   get 'static_pages/home'

#   get 'static_pages/help'

#   root 'application#hello' # 普通は#を使わない。 "/"  を使う。
# end

# # Rails.application.routes.draw do
#   get 'static_pages/home'

#   get 'static_pages/help'

# #   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# # end
