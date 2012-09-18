class ArtifactsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create]
  #before_filter :correct_user, only: [:new, :create]

  def index
    if @user.nil?
      @artifacts = Artifact.all
    else
      @artifacts = @user.artifacts
    end
  end

  def new
    @artifact = Artifact.new
  end

  def create
    @artifact = Artifact.new(params[:artifact])
    @artifact.user = current_user
    if @artifact.save
      redirect_to @artifact
    else
      render 'new'
    end
  end

  def show
    @artifact = Artifact.find(params[:id])
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end

  end

=begin
  def correct_user
    @user = Artifact.find(params[:id]).user
    redirect_to(root_path) unless current_user?(@user)
  end
=end
end
