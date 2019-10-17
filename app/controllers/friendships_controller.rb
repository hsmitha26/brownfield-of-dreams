# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_handle: params[:friend_id])
    if friend
      @friendship = current_user.friendships.create(friend_id: friend.id)
      flash[:notice] = 'Added friend.'
    else
      flash[:notice] = 'Unable to add friend.'
    end
    redirect_to dashboard_path
  end
end
