# リスト 3.4:helloアクションをApplicationコントローラーに追加する
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "hello, world!"
  end
end

# class ApplicationController < ActionController::Base
#   protect_from_forgery with: :exception
# end
