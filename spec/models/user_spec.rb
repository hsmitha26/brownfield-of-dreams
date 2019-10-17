# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  describe 'relationships' do
    it {should have_many :user_videos}
    it {should have_many(:videos).through(:user_videos)}
    it {should have_many :friendships}
    it {should have_many(:friends).through(:friendships)}
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:password_digest) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    it 'can friend?' do
      user_1 = create(:user)
      user_2 = create(:user, github_handle: "Test")

      expect(user_1.can_friend?(user_2.github_handle)).to be true

      user_1.friendships.create(friend_id: user_2.id)

      expect(user_1.can_friend?(user_2.github_handle)).to be false
    end

    it 'set confirmation token' do
      user = create(:user, confirm_token: nil)

      user.set_confirmation_token

      expect(user.confirm_token).to_not be nil
    end

    it 'validate email' do
      user = create(:user, email_confirmed: false, confirm_token: '123')

      user.validate_email

      expect(user.confirm_token).to be nil
      expect(user.email_confirmed).to be true
    end
  end
end
