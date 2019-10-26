class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[show edit update]
  before_action :set_target_user, only: %i[show edit update]
  
  def new
    @user = User.new(flash[:user])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      flash[:user] = user
      flash[:error_messages] = user.errors.full_messages
      redirect_back(fallback_location: new_user_path)
    end
  end

  def show
    @fav_articles = @user.fav_articles.page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      session[:user_id] = @user.id
      redirect_to mypage_path, flash: {
        success: "[ユーザ情報]を更新しました"
      }
    else
      flash[:user] = @user
      flash[:error_messages] = @user.errors.full_messages
      redirect_back(fallback_location: edit_user_path)
    end
  end
  
  private

  #strong params
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def set_target_user
    @user = User.find(@current_user.id) if @current_user
  end

end
