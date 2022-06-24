class PostsController < ApplicationController
  load_and_authorize_resource
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

    if @post.text.size.positive?
      if @post.save
        redirect_to user_path(id: @post.user_id), notice: 'Your post created successfully'
      else
        render :new, alert: 'An error occured while creating post'
      end
    else
      redirect_to new_user_post_url, alert: 'You forget to add any post.'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    if @post.destroy
      redirect_to user_path(params[:user_id])
    else
      redirect_to user_posts_path(params[:user_id], params[:id])
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
