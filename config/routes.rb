# リスト 7.3:Usersリソースをroutesファイルに追加する
# config/routes.rb

Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  resources :users    # リスト 7.3:Usersリソースをroutesファイルに追加する
end



# リスト 5.43:ユーザー登録ページのルート red
# リスト 5.27:静的なページのルーティング一覧 red
# config/routes.rb

# Rails.application.routes.draw do
#   root 'static_pages#home'
#   get  '/help',    to: 'static_pages#help'
#   get  '/about',   to: 'static_pages#about'
#   get  '/contact', to: 'static_pages#contact'
#   get  '/signup',  to: 'users#new'
# #   get 'users/new'   # リスト 5.27:静的なページのルーティング一覧 red
# end


# リスト 5.27:静的なページのルーティング一覧 red
# config/routes.rb

# Rails.application.routes.draw do
#   get 'users/new'

#   root 'static_pages#home'
#   get  '/help',    to: 'static_pages#help'
#   get  '/about',   to: 'static_pages#about'
#   get  '/contact', to: 'static_pages#contact'
# end



# リスト 5.23:Contactページのルートを追加する red
# config/routes.rb
# #
# Rails.application.routes.draw do
#   root 'static_pages#home'
#   get  'static_pages/home'
#   get  'static_pages/help'
#   get  'static_pages/about'
#   get  'static_pages/contact'
# end


# リスト 3.41:HomeページをルートURLに設定する
# config/routes.rb

# Rails.application.routes.draw do
#   root 'static_pages#home'
#   get  'static_pages/home'
#   get  'static_pages/help'
#   get  'static_pages/about'
# end



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
