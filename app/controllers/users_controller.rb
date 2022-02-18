class UsersController < ApplicationController
  before_action :login, only: [:show, :discover]

  def show
  end

  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      redirect_to "/register"
      flash[:alert] = user.errors.full_messages.to_sentence
    end
  end

  def discover
  end

  def login_form
  end

  def login_user
    user = User.find_by_email(params[:email])

    if user == nil
      flash[:alert] = "Email not found"
      redirect_to "/login"
    elsif user.authenticate(params[:password]) == false
      flash[:alert] = "Incorrect Password"
      redirect_to "/login"
    elsif user.authenticate(params[:password]) == user
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      flash[:alert] = "Something went wrong"
      redirect_to "/login"
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
