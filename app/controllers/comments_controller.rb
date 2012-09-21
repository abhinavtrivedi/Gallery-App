class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @artifact = Artifact.find params[:artifact_id]
    @comment = @artifact.comments.create(params[:comment])
    @comment.user = current_user
    if @comment.save
      redirect_to artifact_path(@artifact)
    else
      flash[:error] = @comment.errors.full_messages
      redirect_to artifact_path(@artifact)
    end

  end
end
