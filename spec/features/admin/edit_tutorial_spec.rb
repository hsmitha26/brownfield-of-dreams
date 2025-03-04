# frozen_string_literal: true

require 'rails_helper'

describe 'An admin' do
  let(:tutorial) { create(:tutorial) }
  let(:admin)    { create(:admin) }

  it 'can edit a tutorial by adding a video' do
    VCR.use_cassette("admin_add_a_video") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_tutorial_path(tutorial)

      click_on 'Add Video'

      fill_in 'video[title]', with: 'How to tie your shoes.'
      fill_in 'video[description]', with: 'Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through.'
      fill_in 'video[video_id]', with: 'J7ikFUlkP_k'
      click_on 'Create Video'

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

      within(first('.video')) do
        expect(page).to have_content('How to tie your shoes.')
      end

      visit edit_admin_tutorial_path(tutorial)

      click_on 'Add Video'

      fill_in 'video[title]', with: 'How to tie your shoes.'

      click_on 'Create Video'

      expect(page).to have_content('Unable to create video.')
    end
  end
end
