class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'You have been signed in.'
      redirect_to user_path(@user)
    else
      flash[:danger] = 'An error occurred. Please ensure you complete all the fields!'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @upcoming_events = @user.upcoming_events
    @past_events = @user.past_events
    @invites = @user.invites
    @hosted_events = @user.hosted_events
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'You must be logged in to do that.'
    redirect_to signin_url
  end
end
