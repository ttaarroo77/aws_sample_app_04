# リスト 13.47:homeアクションにフィードのインスタンス変数を追加する
# リスト 13.40:homeアクションにマイクロポストのインスタンス変数を追加する
# app/controllers/static_pages_controller.rb

class StaticPagesController < ApplicationController #  13.47
  def home
    if logged_in?   #  13.47
      @micropost  = current_user.microposts.build  	
      @feed_items = current_user.feed.paginate(page: params[:page])
     #  @micropost = current_user.microposts.build if logged_in?				#  13.40
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end


# リスト 5.24:Contactページ用のアクションを追加する red
# app/controllers/static_pages_controller.rb

# class StaticPagesController < ApplicationController
#   def home
#     #app/views/
#   end

#   def help
#   end
  
#   def about
#   end
  
#   def contact
#   end
  
# end


# リスト 3.8:リスト 3.6で生成されるStaticPagesコントローラ
# app/controllers/static_pages_controller.rb

# class StaticPagesController < ApplicationController
#   def home
#   end

#   def help
#   end
# end