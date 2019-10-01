class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  def new
  end

  def create
  end

  def index
  end

  private
    def require_login
      unless logged_in?
        flash[:warning] = "You must be logged in to use this feature."
        redirect_to login_path
      end
    end
end
