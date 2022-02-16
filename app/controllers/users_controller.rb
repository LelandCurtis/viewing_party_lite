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
      flash[:alert] = "Error: please enter a name and unique email to register."
    end
  end

  def discover
    @user = User.find(params[:user_id])
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
