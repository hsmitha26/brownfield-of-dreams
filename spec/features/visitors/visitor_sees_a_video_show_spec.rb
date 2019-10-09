# frozen_string_literal: true

require 'rails_helper'

describe 'visitor sees a video show' do
  it 'visitor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

  it "visitor sees an error message if tutorial does not have any videos" do
    tutorial = create(:tutorial)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content("This tutorial does not have any videos.")
  end
end
