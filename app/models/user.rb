# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates_presence_of :email, uniqueness: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  validates_presence_of :last_name

  enum role: %i[default admin]

  has_secure_password
end
