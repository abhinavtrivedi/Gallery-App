class BidsController < ApplicationController
  before_filter :signed_in_user

  def edit
    @artifact = Artifact.find(params[:id])
  end

  def update
    @artifact = Artifact.find(params[:id])

    if current_user?(@artifact.user)
      flash[:error] = "Don't get high on 'your own' supply!"
      render 'show'
    elsif params[:artifact][:bid_price].empty?
      flash[:error] = "Please enter a bid"
      redirect_to edit_bid_path(@artifact)
    elsif params[:artifact][:bid_price].to_i <= @artifact.price
      flash[:error] = "Bid must be higher than artifact price of $#{@artifact.price}"
      redirect_to edit_bid_path(@artifact)
    elsif @artifact.bid_price.nil?
      @artifact.bid_price = params[:artifact][:bid_price]
      @artifact.bid_user_id = current_user.id
      @artifact.bid_at = Time.now
      @artifact.save
      flash[:success] = 'Thank you. Your bid has been recorded.'
      redirect_to bid_path(@artifact)
    elsif @artifact.bid_price > params[:artifact][:bid_price].to_i
      flash[:error] = "Your bid price of $#{params[:artifact][:bid_price]} must be higher than current bid of $#{@artifact.bid_price}"
      redirect_to edit_bid_path(@artifact)
    else
      @artifact.bid_price = params[:artifact][:bid_price]
      @artifact.bid_user_id = current_user.id
      @artifact.bid_at = Time.now
      @artifact.save
      flash[:success] = 'Thank you. Your bid has been recorded.'
      redirect_to bid_path(@artifact)
    end
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

  def show
    @artifact = Artifact.find(params[:id])
  end

end
