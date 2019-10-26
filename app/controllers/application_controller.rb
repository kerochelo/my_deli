class ApplicationController < ActionController::Base
  before_action :current_user

  def authenticate_user
    if @current_user == nil
      redirect_to root_path, flash: {
        notice: "ログインしてください"
      }
    end
  end

  private

  def current_user
    return unless session[:user_id]
    @current_user = User.find_by(id: session[:user_id])
  end
end
