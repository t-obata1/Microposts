class UsersController < ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  
   if @user.save
    flash[:success] = "ユーザを登録しました。"
    redirect_to @user # users#showアクションが実行され、show.html.ernへ
   else
    flash.now[:danger] = "ユーザの登録に失敗しました"
    render :new #mew.htmml.erbが呼び出される
   end
   
  end


private

  def user_params #require 必要とする  #permit 許可する
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end

