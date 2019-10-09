# frozen_string_literal: true

require 'rails_helper'

describe 'As a User' do
  it 'the root page does display classroom content tutorials' do
    user = create(:user)

    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial, classroom: true)

    video_1 = create(:video, tutorial_id: tutorial_1.id)
    video_2 = create(:video, tutorial_id: tutorial_1.id)
    video_3 = create(:video, tutorial_id: tutorial_2.id)
    video_4 = create(:video, tutorial_id: tutorial_2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    expect(page).to have_css('.tutorial', count: 2)

    within('.tutorials') do
      expect(page).to have_css('.tutorial')
      expect(page).to have_css('.tutorial-description')
      expect(page).to have_content(tutorial_1.title)
      expect(page).to have_content(tutorial_1.description)
      expect(page).to have_css('.tutorial')
      expect(page).to have_css('.tutorial-description')
      expect(page).to have_content(tutorial_2.title)
      expect(page).to have_content(tutorial_2.description)
    end
  end
end
