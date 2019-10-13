require 'rails_helper'

describe "An admin visiting the admin dashboard" do
  it "allows admin to add new tutorial" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit '/admin/dashboard'

    click_on 'New Tutorial'
    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in 'tutorial[title]', with: 'Brownfield of Dreams'
    fill_in 'tutorial[description]', with: 'Tips to work in a brownfield project.'
    fill_in 'tutorial[thumbnail]', with: 'http://i3.ytimg.com/vi/BotaoeIFrYE/maxresdefault.jpg'

    click_on 'Save'
    expect(page).to have_content('Successfully added tutorial.')

    new_tutorial_id = Tutorial.last.id
    expect(current_path).to eq(tutorial_path(new_tutorial_id))
  end

  # sad path testing
  it "displays a flash message if tutorial was not added" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit '/admin/dashboard'

    click_on 'New Tutorial'
    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in 'tutorial[title]', with: 'Brownfield of Dreams'
    fill_in 'tutorial[description]', with: 'Tips to work in a brownfield project.'

    click_on 'Save'
    expect(page).to have_content('Tutorial was not added.')
    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in 'tutorial[title]', with: 'Brownfield of Dreams'
    fill_in 'tutorial[description]', with: 'Tips to work in a brownfield project.'
    fill_in 'tutorial[thumbnail]', with: 'http://i3.ytimg.com/vi/BotaoeIFrYE/maxresdefault.jpg'
    click_on 'Save'

    new_tutorial_id = Tutorial.last.id
    expect(current_path).to eq(tutorial_path(new_tutorial_id))
  end
end
