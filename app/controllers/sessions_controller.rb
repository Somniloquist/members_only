class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      login @user
      current_user = @user
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
  end
end
