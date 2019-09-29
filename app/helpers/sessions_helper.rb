module SessionsHelper
  def login(user)
    remember_token = @user.generate_remember_token
    @user.update_attribute(:remember_token, remember_token)
    cookies.signed.permanent[:remember_token] = remember_token
  end

  def current_user
    @current_user ||= session[:current_user_id] && User.find_by(remember_token: cookies[:remember_token])
  end

  def current_user=(user)
    @current_user = user
  end
end
  