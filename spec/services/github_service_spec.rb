require 'rails_helper'

describe GithubService do
  before(:each) do
    @user = create(:user, github_token: ENV['example_github_token'])
    @github_service = GithubService.new(@user)
  end

  it "exists" do
    expect(@github_service).to be_a(GithubService)
  end

  it "gets repos for the user" do
    VCR.use_cassette("github_service_repos") do
      json_response = @github_service.get_repos
      repo = json_response.first
      expect(repo).to have_key("name")
      expect(repo).to have_key("html_url")
    end
  end

  it "gets followers for the user" do
    VCR.use_cassette("github_service_followers") do
      json_response = @github_service.get_followers
      follower = json_response.first
      expect(follower).to have_key("login")
      expect(follower).to have_key("html_url")
    end
  end
end
