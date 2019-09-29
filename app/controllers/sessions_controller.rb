class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      login @user
      redirect_to @user, :locals => {:id => session[:current_user_id]}
    else
      render :new
    end
  end

  def destroy
    logout
  end
end
