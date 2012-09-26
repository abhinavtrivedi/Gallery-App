class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @artifact = Artifact.find params[:artifact_id]
    @comment = @artifact.comments.create(params[:comment])
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        Artifact.increment_counter(:comment_count, params[:artifact_id])
        format.html {redirect_to artifact_path(@artifact)}
        format.js
        #respond_with @artifact, :location => artifact_url
        #redirect_to artifact_path(@artifact)
        #render :partial => 'comment', :object => @comment
      else
        flash[:error] = @comment.errors.full_messages
        format.html {redirect_to artifact_path(@artifact)}
        format.js
      end
    end


  end
end
