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
end
