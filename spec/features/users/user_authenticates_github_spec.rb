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
    visit '/'
    create(:user)
    binding.pry
  end
end
