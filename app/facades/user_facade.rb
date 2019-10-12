# frozen_string_literal: true

class UserFacade

  def initialize(user)
    @github_service = GithubService.new(user)
  end

  def format_repos(num)
    full_repos_array = @github_service.get_repos
    full_repos_array[0..(num - 1)].map do |repo_hash|
      Repository.new(repo_hash["name"], repo_hash["html_url"])
    end
  end

  def format_followers
    full_followers_array = @github_service.get_followers
    full_followers_array.map do |follower_hash|
      GithubUser.new(follower_hash["login"], follower_hash["html_url"])
    end
  end

  def format_following
    full_following_array = @github_service.get_following
    full_following_array.map do |following_hash|
      GithubUser.new(following_hash["login"], following_hash["html_url"])
    end
  end
end
