class FriendshipsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  def index
     @users = User.all - [current_user] - current_user.friends
  end

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to friendships_path
    else
      flash[:notice] = "Unable to add friend."
      redirect_to friendships_path
    end
  end

  def show
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to friendships_path
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to friendships_path
  end
end