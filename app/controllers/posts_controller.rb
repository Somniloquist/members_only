class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  def new
  end

  def create
    @post = Post.new(post_params)
    @post.update_attribute(:user_id, current_user.id)
    if @post.save
      flash[:success] = "Post successfully created!"
      redirect_to action: :index
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  private
    def require_login
      unless logged_in?
        flash[:warning] = "You must be logged in to use this feature."
        redirect_to login_path
      end
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
