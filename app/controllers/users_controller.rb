=begin
The MIT License

Copyright (c) 2012 Michael Hartl

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

----------------------------------------------------------------------------
"THE BEER-WARE LICENSE" (Revision 42):
 Michael Hartl wrote this code. As long as you retain this notice you
 can do whatever you want with this stuff. If we meet some day, and you think
 this stuff is worth it, you can buy me a beer in return.
----------------------------------------------------------------------------
=end

class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :show]
  before_filter :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    if Rails.env.production?
      @new_artifacts = Artifact.find_all_by_user_id(params[:id], order: "created_at DESC")
      @popular_artifacts = Artifact.find_all_by_user_id(params[:id], order: 'comment_count DESC NULLS LAST')
      @latest_bid_artifacts = Artifact.find_all_by_user_id(params[:id], order: 'bid_at DESC NULLS LAST')
    else
      @new_artifacts = Artifact.find_all_by_user_id(params[:id], order: "created_at DESC")
      @popular_artifacts = Artifact.find_all_by_user_id(params[:id], order: 'comment_count DESC')
      @latest_bid_artifacts = Artifact.find_all_by_user_id(params[:id], order: 'bid_at DESC')
    end

  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Gallery, #{@user.name}!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end

  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end
