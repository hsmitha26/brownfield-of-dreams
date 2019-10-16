require 'rails_helper'

describe "A logged in user: " do
  before(:each) do
    @json_repos = File.open('./fixtures/repo_data.json')
    stub_request(:get, "https://api.github.com/user/repos?access_token=#{ENV['example_github_token']}")
      .to_return(status: 200, body: @json_repos)

    @json_followers = File.open('./fixtures/follower_data.json')
    stub_request(:get, "https://api.github.com/user/followers?access_token=#{ENV['example_github_token']}")
      .to_return(status: 200, body: @json_followers)

    @json_following = File.open('./fixtures/following_data.json')
    stub_request(:get, "https://api.github.com/user/following?access_token=#{ENV['example_github_token']}")
      .to_return(status: 200, body: @json_following)
  end

  it "can connect to Github via OAuth" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      info: {
        nickname: 'tschaffer1618'
      },
      credentials: {
        token: ENV['example_github_token'],
      }
    )

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_on 'Connect to GitHub'

    expect(current_path).to eq dashboard_path

    expect(page).to_not have_content('Connect to GitHub')

    expect(page).to have_content("My GitHub")
  end
end
