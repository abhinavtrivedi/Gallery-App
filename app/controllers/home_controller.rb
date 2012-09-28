class HomeController < ApplicationController
  def index
    if Rails.env.production?
      @new_artifacts = Artifact.order("created_at DESC NULLS LAST").limit(3)
      @popular_artifacts = Artifact.order("comment_count DESC NULLS LAST").limit(3)
      @latest_bid_artifacts = Artifact.order("bid_at DESC NULLS LAST").limit(3)
    else
      @new_artifacts = Artifact.order("created_at DESC").limit(3)
      @popular_artifacts = Artifact.order("comment_count DESC").limit(3)
      @latest_bid_artifacts = Artifact.order("bid_at DESC").limit(3)
    end

  end
end
