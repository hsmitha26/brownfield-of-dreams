require 'rails_helper'

describe "An admin visiting the admin dashboard" do
  it "allows admin to add new tutorial" do
    admin = create(:admin)
    create_list(:tutorial, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit '/admin/dashboard'
    expect(page).to have_css('.admin-tutorial-card', count: 2)

    save_and_open_page


  end
end
    # When I visit '/admin/tutorials/new'
    # And I fill in 'title' with a meaningful name
    # And I fill in 'description' with a some content
    # And I fill in 'thumbnail' with a valid YouTube thumbnail
    # And I click on 'Save'
    # Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
    # And I should see a flash message that says "Successfully created tutorial."
