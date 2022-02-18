class ApplicationController < ActionController::Base

  def login
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      flash[:alert] = 'You must log in to see this page'
      redirect_to '/login'
    end
  end
end
