require 'rails_helper'

describe 'A user' do
  it 'can add friends from the github followers or following' do
    user_1 = create(:user, github_token: ENV['example_github_token'])
    user_2 = create(:user, first_name: 'Name', last_name: 'Test', github_handle: 'StarPerfect')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

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

    within(".followers") do
      click_on "Add Friend"
    end

    expect(current_path).to eq dashboard_path
    within(".followers") do
      expect(page).to_not have_content("Add Friend")
    end
  end

  it 'can see friends on the dashboard' do
    user_1 = create(:user, github_token: ENV['example_github_token'])
    user_2 = create(:user, first_name: 'Name', last_name: 'Test', github_handle: 'StarPerfect')
    user_1.friendships.create(friend_id: user_2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

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

    within(".friends") do
      expect(page).to have_content(user_2.first_name)
      expect(page).to have_content(user_2.last_name)
      expect(page).to have_content(user_2.github_handle)
    end
  end
end
