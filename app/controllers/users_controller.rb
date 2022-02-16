class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      redirect_to user_path(user)
    else
      redirect_to "/register"
      flash[:alert] = user.errors.full_messages.to_sentence
    end
  end

  def discover
    @user = User.find(params[:user_id])
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
      redirect_to "/users/#{user.id}"
    else
      flash[:alert] = "Something went wrong"
      redirect_to "/login"
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
