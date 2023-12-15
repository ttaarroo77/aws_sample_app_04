# リスト 8.13:ApplicationコントローラにSessionヘルパーモジュールを読み込む
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
end


# リスト 3.4:helloアクションをApplicationコントローラーに追加する
# app/controllers/application_controller.rb

# class ApplicationController < ActionController::Base
#   protect_from_forgery with: :exception

#   def hello
#     render html: "hello, world!"
#   end
# end


# class ApplicationController < ActionController::Base
#   protect_from_forgery with: :exception
# end



# 継承元ファイルの情報
# app/models/application_record.rb

# class ApplicationRecord < ActiveRecord::Base
#   self.abstract_class = true
# end

# ActiveRecord::Base の先は不明

