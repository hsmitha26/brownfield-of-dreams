# frozen_string_literal: true

namespace :update_video do
  desc 'Change any nil video descriptions to 0'

  task position: :environment do
    videos = Video.where(position: nil)
    videos.each do |video|
      video.update(position: 0)
    end
  end
end
