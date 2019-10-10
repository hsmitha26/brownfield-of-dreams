class GithubController < ApplicationController

  def create
    token = request.env["omniauth.auth"]["credentials"]["token"]
    current_user.update(github_token: token)
    redirect_to '/dashboard'
  end

end
