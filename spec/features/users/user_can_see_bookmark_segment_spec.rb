require 'rails_helper'

describe 'A registered user' do
  it "can display Bookmarked" do
    user = create(:user)

    t1 = create(:tutorial, title: 'How to Tie Your Shoes')
    t1v1 = create(:video, title: 'The Bunny Ears Technique', tutorial: t1)
    t1v2 = create(:video, tutorial: t1)

    t2 = create(:tutorial)
    t2v1 = create(:video, tutorial: t2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit tutorial_path(t1)
    click_on 'Bookmark'

    visit dashboard_path
    expect(page).to have_content("Bookmarked Segments")

    save_and_open_page


    # Then I should see a list of all bookmarked segments under the Bookmarked Segments section
    # And they should be organized by which tutorial they are a part of
    # And the videos should be ordered by their position
  end
end
