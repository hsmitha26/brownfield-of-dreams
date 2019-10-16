require 'rails_helper'

describe 'A user' do
  before(:each) do
    @user = create(:user, github_token: ENV['example_github_token'], confirm_token: '123')

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

  it 'can authenticate their account by email' do
    visit '/'

    click_on "Sign In"

    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password

    click_on 'Log In'

    expect(current_path).to eq dashboard_path

    expect(page).to have_content("This account has not yet been activated. Please check your email.")

    visit "/#{@user.confirm_token}/confirm_email"

    expect(current_path).to eq dashboard_path

    expect(page).to have_content("Status: Active")
  end
end
