module SessionsHelper
  def login(user)
    # provide a new token so it does not get stolen or stale
    remember_token = @user.generate_remember_token
    @user.update_attribute(:remember_token, remember_token)
    cookies.signed.permanent[:remember_token] = remember_token
    @current_user = user
  end

  def logout
    @current_user = nil
    cookies[:remember_token].delete
  end

  def current_user
    @current_user ||= User.find_by(remember_token: cookies[:remember_token])
  end

  def current_user=(user)
    @current_user = user
  end
end
  