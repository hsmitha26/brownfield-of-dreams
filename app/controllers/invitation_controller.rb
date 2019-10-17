# frozen_string_literal: true

class InvitationController < ApplicationController
  def new; end

  def create
    service = GithubService.new(current_user)
    invited_user = service.get_user(params['GitHub Handle'])
    if invited_user && invited_user['email']
      UserMailer.invitation(current_user, invited_user).deliver_now
      flash[:sucess] = 'Successfully sent invite!'
    elsif invited_user['login']
      flash[:error] = 'The invited user does not have a public email address.'
    else
      flash[:error] = 'The invited user does not exist.'
    end
    redirect_to dashboard_path
  end
end
