class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  #HTTPリクエスト POST  /microposts/:micropost_id/favorites(.:format)   favorites#create
  
  # def favorite(引数)
  #   favarites.find_or_create_by(引数_id: micropost.id)  
  # end
  
  def create 
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = '投稿をお気に入りしました。'
    redirect_back(fallback_location: root_path)
  end

  # def unfavorite(micropost)
  #   favorite = favorites.find_by(micropost_id: micropost.id)
  #   favorites.destroy if favorite
  # end
  
  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = '投稿のお気に入りを削除しました。'
    redirect_back(fallback_location: root_path)
  end
end
