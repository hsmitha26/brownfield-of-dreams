# frozen_string_literal: true

class InvitationController < ApplicationController
  def new; end

  def create
    service = GithubService.new(current_user)
    invited_user = service.fetch_user(params['GitHub Handle'])
    check_invited_user(invited_user)
    redirect_to dashboard_path
  end

  private

  def check_invited_user(user)
    if user && user['email']
      UserMailer.invitation(current_user, user).deliver_now
      flash[:sucess] = 'Successfully sent invite!'
    elsif user['login']
      flash[:error] = 'The invited user does not have a public email address.'
    else
      flash[:error] = 'The invited user does not exist.'
    end
  end
end
