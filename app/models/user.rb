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
    friendship = Friendship.find_by(user_id: id, friend_id: user.id) if user
    (user && !friendship)
  end

  def set_confirmation_token
    token = SecureRandom.urlsafe_base64.to_s
    update(confirm_token: token) if confirm_token.blank?
  end

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
  end
end
