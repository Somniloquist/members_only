module SessionsHelper
  def login(user)
    # provide a new token so it does not get stolen or stale
    remember user
    session[:current_user_id] = user.id
    current_user = user
  end

  def logout
    @current_user = nil
    session.delete :current_user_id
    cookies.delete :remember_token
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(remember_token: cookies[:remember_token])
  end

  def remember(user)
    remember_token = user.generate_remember_token
    user.update_attribute(:remember_token, remember_token)
    cookies.permanent[:remember_token] = remember_token
  end


  def current_user=(user)
    @current_user = user
  end
end
  