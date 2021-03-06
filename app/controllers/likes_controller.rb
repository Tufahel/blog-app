class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user_id: @post.user_id, post_id: @post)

    if @like.save
      redirect_to user_post_path(user_id: @post.user_id, id: @post.id), notice: 'Ya, you liked this post'
    else
      render :new, alert: 'An error occurred while hitting like'
    end
  end
end
