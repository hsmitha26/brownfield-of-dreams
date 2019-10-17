# frozen_string_literal: true

require 'rails_helper'

describe Tutorial, type: :model do
  describe 'relationships' do
    it {should have_many :videos}
    it {should accept_nested_attributes_for :videos}
  end

  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:thumbnail)}
  end

  describe 'instance methods' do
    it '.bookmarked_videos' do
      user = create(:user)
      u2 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      t1 = create(:tutorial, title: 'How to Tie Your Shoes')
      t1v1 = create(:video, title: 'The Bunny Ears Technique', tutorial: t1, position: 2)
      t1v2 = create(:video, tutorial: t1, position: 1)
      t1v3 = create(:video, tutorial: t1, position: 3)

      t2 = create(:tutorial)
      t2v1 = create(:video, tutorial: t2)

      uv1 = create(:user_video, user_id: user.id, video_id: t1v1.id)
      uv2 = create(:user_video, user_id: user.id, video_id: t1v2.id)
      uv3 = create(:user_video, user_id: user.id, video_id: t2v1.id)

      uv4 = create(:user_video, user_id: u2.id, video_id: t1v3.id)

      expect(t1.bookmarked_videos(user)).to eq([t1v2, t1v1])
      expect(t2.bookmarked_videos(user)).to eq([t2v1])

      expect(t1.bookmarked_videos?(user)).to be true
      expect(t2.bookmarked_videos?(user)).to be true
    end
  end
end
