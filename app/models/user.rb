# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates_presence_of :email, uniqueness: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  validates_presence_of :last_name

  enum role: %i[default admin]

  has_secure_password

  def can_friend?(handle)
    user = User.find_by(github_handle: handle)
    friendship = Friendship.find_by(user_id: self.id, friend_id: user.id) if user
    return(user && !friendship)
  end
end
