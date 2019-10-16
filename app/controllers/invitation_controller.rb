# frozen_string_literal: true

class InvitationController < ApplicationController
  def new
  end

  def create
    service = GithubService.new(current_user)
    invited_user = service.get_user(params['GitHub Handle'])
    binding.pry
    if invited_user && invited_user['email']
      UserMailer.invitation(current_user, invited_user).deliver_now!
    elsif invited_user
      flash[:error] = "The invited user does not have a public email address."
    else
      flash[:error] = "The invited user does not exist."
    end
    redirect_to dashboard_path
  end
end
