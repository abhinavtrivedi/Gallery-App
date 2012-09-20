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

  def update
    @artifact = Artifact.find(params[:id])

    if current_user?(@artifact.user)
      flash[:error] = "Don't get high on 'your own' supply!"
    elsif params[:artifact][:bid_price].empty?
      flash[:error] = "Please enter a bid"
    elsif params[:artifact][:bid_price].to_i <= @artifact.price
      flash[:error] = "Bid must be higher than artifact price of $#{@artifact.price}"
    elsif @artifact.bid_price.nil?
      @artifact.bid_price = params[:artifact][:bid_price]
      @artifact.bid_user_id = current_user.id
      @artifact.bid_at = Time.now
      @artifact.save
      flash[:success] = 'Thank you. Your bid has been recorded.'
    elsif @artifact.bid_price > params[:artifact][:bid_price].to_i
      flash[:error] = "Your bid price of $#{params[:artifact][:bid_price]} must be higher than current bid of $#{@artifact.bid_price}"
    else
      @artifact.bid_price = params[:artifact][:bid_price]
      @artifact.bid_user_id = current_user.id
      @artifact.bid_at = Time.now
      @artifact.save
      flash[:success] = 'Thank you. Your bid has been recorded.'
    end
    redirect_to bid_path(@artifact)
=begin
    if @artifact.bid_price > params[:bid_price]
      #flash[:error] = "Your bid must be higher than current bid of $#{@artifact.bid_price}"
      flash[:error] = "Your have entered #{params[:bid_price]}"
      render 'edit'
    else
      @artifact.bid_price = params[:artifact][:bid_price]
      @artifact.bid_user_id = current_user.id
      @artifact.bid_at = Time.now.to_i
      @artifact.save
      flash[:success] = 'Thank you. Your bid has been recorded.'
      render 'show'
    end
=end
  end

=begin
  def correct_user
    @user = Artifact.find(params[:id]).user
    redirect_to(root_path) unless current_user?(@user)
  end
=end
end
