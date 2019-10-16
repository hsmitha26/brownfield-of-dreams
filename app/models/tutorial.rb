# frozen_string_literal: true

class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :thumbnail


  def bookmarked_videos(user)
    user.videos
        .where(tutorial_id: self.id)
        .order('position ASC')
  end
end
