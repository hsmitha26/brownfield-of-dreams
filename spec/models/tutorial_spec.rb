# frozen_string_literal: true

require 'rails_helper'

describe Tutorial, type: :model do
  describe 'relationships' do
    it {should have_many :videos}
  end
end
