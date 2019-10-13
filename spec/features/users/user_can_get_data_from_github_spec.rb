require 'rails_helper'

describe "A user connected to github" do
  it "will have github repos, followers and following on the dashboard" do
    user = create(:user, github_token: ENV['example_github_token'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    json_repos = File.open('./fixtures/repo_data.json')
    stub_request(:get, "https://api.github.com/user/repos?access_token=#{ENV['example_github_token']}")
      .to_return(status: 200, body: json_repos)

    json_followers = File.open('./fixtures/follower_data.json')
    stub_request(:get, "https://api.github.com/user/followers?access_token=#{ENV['example_github_token']}")
      .to_return(status: 200, body: json_followers)

    json_following = File.open('./fixtures/following_data.json')
    stub_request(:get, "https://api.github.com/user/following?access_token=#{ENV['example_github_token']}")
      .to_return(status: 200, body: json_following)
    visit dashboard_path

    expect(page).to have_content("My GitHub")
    expect(page).to have_content("Repositories")
    expect(page).to have_link("brownfield-of-dreams")

    expect(page).to have_content("Followers")
    expect(page).to have_link("leiyakenney")

    expect(page).to have_content("Following")
    expect(page).to have_link("hillstew")
  end
end
