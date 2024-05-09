# 13.61:pictureを許可された属性のリストに追加　//   #  13.61: 13.52: 13.50: 13.36: 13.34:
# app/controllers/microposts_controller.rb

class MicropostsController  < ApplicationController
 before_action :logged_in_user, only: [:create, :destroy]
 before_action :correct_user,   only: :destroy

  def create  # 13.34
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else  # 13.50
      @feed_items = current_user.feed.paginate(page: params[:page])
      ###   @feed_items = []									# 13.50
      render 'static_pages/home'
    end
  end

  def destroy # 13.34    # 13.52
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  private
    def micropost_params
      params.require(:micropost).permit(:content, :picture) # 13.61
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id]) # 13.52
      redirect_to root_url if @micropost.nil?
    end
end