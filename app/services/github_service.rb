# frozen_string_literal: true

class GithubService

  def initialize(user)
    @user = user
  end

  def get_repos
    oauth_response = conn.get('repos')
    JSON.parse(oauth_response.body)
  end

  def get_followers
    oauth_response = conn.get('followers')
    JSON.parse(oauth_response.body)
  end

  private

  def conn
    token = @user.github_token
    Faraday.new(url: "https://api.github.com/user", params: {access_token: token})
  end

end
