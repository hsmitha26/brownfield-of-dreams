require 'rails_helper'

# As a user
# When I visit /dashboard
# Then I should see a link that is styled like a button that says "Connect to Github"
# And when I click on "Connect to Github"
# Then I should go through the OAuth process
# And I should be redirected to /dashboard
# And I should see all of the content from the previous Github stories (repos, followers, and following)

describe "A logged in user: " do
  it "can connect to Github" do
    # tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    # video = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    expect(page).to have_link('Connect to GitHub')
    # save_and_open_page
    # binding.pry
  end
end
