class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in user
      flash[:success] = 'You have been signed in.'
    else
      render 'new'
    end
  end
  
  def show
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
