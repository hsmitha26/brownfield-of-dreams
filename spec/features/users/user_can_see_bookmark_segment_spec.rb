require 'rails_helper'

describe 'A registered user' do
  it "can display Bookmarked" do
    tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    video = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    # When I visit '/dashboard'
    # Then I should see a list of all bookmarked segments under the Bookmarked Segments section
    # And they should be organized by which tutorial they are a part of
    # And the videos should be ordered by their position
  end
end
