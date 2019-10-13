require 'rails_helper'

describe 'An admin visiting the admin dashboard' do
  before :each do
    @admin = create(:admin)
    @t1, @t2, @t3 = create_list(:tutorial, 3)
    @t1v1 = create(:video, tutorial_id: @t1.id)
    @t2v2 = create(:video, tutorial_id: @t2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit admin_dashboard_path
  end
  it 'can delete a tutorial and associated videos' do
    within(first('.admin-tutorial-card')) do
      click_on 'Destroy'
    end

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to_not have_content(@t1.title)
    expect(@t1.videos.count).to eq(0)
    expect(page).to have_content(@t2.title)
    expect(page).to have_content(@t3.title) 
  end
end
