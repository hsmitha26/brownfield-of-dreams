# frozen_string_literal: true

require 'rails_helper'

describe Video, type: :model do
  describe 'relationships' do
    it {should belong_to :tutorial}
    it {should have_many :user_videos}
    it {should have_many(:users).through(:user_videos)}
  end

  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:video_id)}
    it {should validate_presence_of(:position)}
  end
end
