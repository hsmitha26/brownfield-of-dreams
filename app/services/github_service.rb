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

  def get_following
    oauth_response = conn.get('following')
    JSON.parse(oauth_response.body)
  end

  def get_user(username)
    token = @user.github_token
    url = 'https://api.github.com/users'
    connection = Faraday.new(url: url, params: { access_token: token })
    oauth_response = connection.get(username.to_s)
    JSON.parse(oauth_response.body)
  end

  private

  def conn
    token = @user.github_token
    url = 'https://api.github.com/user'
    Faraday.new(url: url, params: { access_token: token })
  end
end
