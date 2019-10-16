require 'rails_helper'

describe 'A user' do
  before(:each) do
    @user = create(:user, github_token: ENV['example_github_token'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

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

  describe 'can invite others to use the app' do
    it "if they have a github and email" do
      json_email = File.open('./fixtures/email_data.json')
      stub_request(:get, "https://api.github.com/users/tschaffer1618?access_token=#{ENV['example_github_token']}")
        .to_return(status: 200, body: json_email)

      visit dashboard_path

      click_on('Send an Invitation')

      expect(current_path).to eq invitation_path

      fill_in 'GitHub Handle', with: 'tschaffer1618'

      click_on 'Send Invitation'

      expect(current_path).to eq dashboard_path
      expect(page).to have_content("Successfully sent invite!")
    end

    it "if they have a github but no email" do
      no_email_data = File.open('./fixtures/no_email_data.json')
      stub_request(:get, "https://api.github.com/users/sadpathtylor?access_token=#{ENV['example_github_token']}")
        .to_return(status: 200, body: no_email_data)

      visit dashboard_path

      click_on('Send an Invitation')

      expect(current_path).to eq invitation_path

      fill_in 'GitHub Handle', with: 'sadpathtylor'

      click_on 'Send Invitation'

      expect(current_path).to eq dashboard_path
      expect(page).to have_content("The invited user does not have a public email address.")
    end

    it "if they do not have a github" do
      no_user_data = File.open('./fixtures/no_user_data.json')
      stub_request(:get, "https://api.github.com/users/lkasdfhlakshfijbvansdbv?access_token=#{ENV['example_github_token']}")
        .to_return(status: 200, body: no_user_data)

      visit dashboard_path

      click_on('Send an Invitation')

      expect(current_path).to eq invitation_path

      fill_in 'GitHub Handle', with: 'lkasdfhlakshfijbvansdbv'

      click_on 'Send Invitation'

      expect(current_path).to eq dashboard_path
      expect(page).to have_content("The invited user does not exist.")
    end
  end
end
