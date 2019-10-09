# frozen_string_literal: true

require 'rails_helper'

describe 'As a Visitor' do
  it 'the root page does not display classroom content tutorials' do
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial, classroom: true)

    video_1 = create(:video, tutorial_id: tutorial_1.id)
    video_2 = create(:video, tutorial_id: tutorial_1.id)
    video_3 = create(:video, tutorial_id: tutorial_2.id)
    video_4 = create(:video, tutorial_id: tutorial_2.id)

    visit root_path

    expect(page).to have_css('.tutorial', count: 1)

    within(first('.tutorials')) do
      expect(page).to have_css('.tutorial')
      expect(page).to have_css('.tutorial-description')
      expect(page).to have_content(tutorial_1.title)
      expect(page).to have_content(tutorial_1.description)
    end
  end
end
