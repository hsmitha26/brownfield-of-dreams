require 'rails_helper'

describe "A logged in user: " do
  xit "can connect to Github via OAuth" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    stub_omniauth
    click_on 'Connect to GitHub'
    user.reload

    expect(user.github_token).to eq('pizza')
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      extra: {
        raw_info: {
          login: "1234"
        }
      },
      credentials: {
        token: "pizza",
      }
    })
  end
end
