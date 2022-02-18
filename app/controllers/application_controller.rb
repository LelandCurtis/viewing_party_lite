class ApplicationController < ActionController::Base
  helper_method :current_user

  def login
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      flash[:alert] = 'You must log in to see this page'
      redirect_to '/login'
    end
  end

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      nil
    end
  end
end
