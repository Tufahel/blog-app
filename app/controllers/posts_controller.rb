class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, :likes)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @likes = @post.likes
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(post_params)
    @post.comment_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_path(id: @post.user_id)
    else
      render :new, alert: 'An error occured while creating post'
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
