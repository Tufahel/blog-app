class CommentsController < ApplicationController
    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params)
        @post = Post.find(params[:post_id])
        @comment.user_id = current_user.id
        @comment.post_id = @post.id

        if @comment.save
            redirect_to user_post_path(user_id: @post.user_id, id: @post.id)
        else
            render :new, alert: 'An error occurred'
        end
    end

    def comment_params
        params.require(:comment).permit(:text)
    end
end