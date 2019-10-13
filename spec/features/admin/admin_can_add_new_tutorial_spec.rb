require 'rails_helper'

describe "An admin visiting the admin dashboard" do
  it "allows admin to add new tutorial" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit '/admin/dashboard'

    click_on 'New Tutorial'
    expect(current_path).to eq(new_admin_tutorial_path)

    # And I fill in 'title' with a meaningful name
    # And I fill in 'description' with a some content
    # And I fill in 'thumbnail' with a valid YouTube thumbnail

  end
end
    # When I visit '/admin/tutorials/new'
    # And I click on 'Save'
    # Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
    # And I should see a flash message that says "Successfully created tutorial."
