# frozen_string_literal: true

require 'rails_helper'

describe UserVideo, type: :model do
  describe 'relationships' do
    it {should belong_to :video}
    it {should belong_to :user}
  end
end
