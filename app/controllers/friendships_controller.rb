class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_handle: params[:friend_id])
    @friendship = current_user.friendships.create(friend_id: friend.id)
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to dashboard_path
    else
      flash[:notice] = "Unable to add friend."
      redirect_to dashboard_path
    end
  end
end
