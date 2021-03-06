class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
    @comments = @post.comments.all
    @comment = @post.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render 'posts/show'
    end
  end 

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "You need to own the comment to delete it."
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Coment couldn't be deleted. Try again." 
      redirect_to [@topic, @post]
    end
  end


end
