module SessionsHelper
  def log_in
    session[:name] = user.name
    @current_user = user
  end

  def current_user
    if user.name = session[:name]
      @current_user ||= User.find_by(name: user.name)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:name)
    @current_user = nil
  end
end
