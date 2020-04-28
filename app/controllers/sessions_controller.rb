class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user
      log_in(user)
      flash[:success] = "Welcome back #{user.name}!"
      redirect_to user
    else
      flash[:danger] = "This name is not in our system. Please try again."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'You have been logged out. Goodbye!'
    redirect_to root_url
  end
end
