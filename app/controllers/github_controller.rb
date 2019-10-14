# frozen_string_literal: true

class GithubController < ApplicationController
  def create
    token = request.env['omniauth.auth']['credentials']['token']
    handle = request.env['omniauth.auth']['info']['nickname']
    current_user.update(github_token: token, github_handle: handle)
    redirect_to '/dashboard'
  end
end
