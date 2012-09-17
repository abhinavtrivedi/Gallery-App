class ArtifactsController < ApplicationController
  def index
    @artifacts = Artifact.all
  end

  def new
    @artifact = Artifact.new
  end

  def create
    @artifact = Artifact.new(params[:artifact])
    if @artifact.save
      redirect_to @artifact
    else
      render 'new'
    end
  end

  def show
    @artifact = Artifact.find(params[:id])
  end
end
