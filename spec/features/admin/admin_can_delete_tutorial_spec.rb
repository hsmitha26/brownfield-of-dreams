require 'rails_helper'

describe 'An admin visiting the admin dashboard' do
  it 'can delete a tutorial and associated videos' do
    admin = create(:admin)
    t1, t2 = create_list(:tutorial, 2)
    tv1 = create(:video, tutorial_id: t1)
    tv2 = create(:video, tutorial_id: t2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit '/admin/dashboard'

  end
end
