class UsersController < ApplicationController
  include SessionsHelper
  def new
    @user = User.new
    if !current_user.nil? then
      redirect_to "accounts/index"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome!"
      redirect_to '/accounts/index'
    else
      flash[:error] = "An error occurred.  Please try again"
      render 'new'
    end
  end

  def show
    if current_user.nil? then
      flash[:error] = "You must be logged in!"
      redirect_to "/signup"
    else
      @user = User.find(current_user.id)
    end
  end

  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
end
