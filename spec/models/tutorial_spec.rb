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
end
