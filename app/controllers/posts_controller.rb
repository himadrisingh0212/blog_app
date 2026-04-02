class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]   
  before_action :authenticate_user!, only: [:new, :create]           # Force login for all actions
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    if current_user.super_admin?
    @posts = Post.all
    else
      @posts=current_user.posts
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user  # attach logged in user
    
    if @post.save
      redirect_to @post, notice: "Post created successfully."
    else
      render :new
    end
  end

  def edit
    render:new
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user == current_user|| current_user.super_admin?
      redirect_to posts_path, alert: "You can only edit your own posts."
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end