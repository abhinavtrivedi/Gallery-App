class BidsController < ApplicationController
  before_filter :signed_in_user

  def new
  end

  def show
    @artifact = Artifact.find(params[:id])
  end
end
